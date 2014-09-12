#!/usr/bin/perl

use strict;
use warnings;
use Spreadsheet::ParseExcel;
use Data::Dumper;
use FindBin;
use lib "$FindBin::Bin/lib";
use CONSTANT;
use common;
use sportdirect;
#use lovellrugby;

###################
# Global variable #
###################
my ($LANGUAGES)				= $CONSTANT::LANGUAGES;
my ($SHOPS)					= $CONSTANT::SHOPS;
my ($SHOP_TMP_DIR)			= $CONSTANT::SHOP_TMP_DIR;
my ($SHOP_PROD_IMG_DIR)		= $CONSTANT::SHOP_PROD_IMG_DIR;				
my ($IMPORT_EXT_PROD_FILE)	= $CONSTANT::IMPORT_EXT_PROD_FILE;

my ($EMAILS_FROM)			= $CONSTANT::EMAILS_FROM;
my ($EMAILS_TO)				= $CONSTANT::EMAILS_TO;
my ($EMAILS_INSERT_SUBJECT)	= $CONSTANT::EMAILS_INSERT_SUBJECT;

# Input parameters
my ($INIT_EXT_FILE) = $ARGV[0];
unless ( defined $INIT_EXT_FILE  ) {
	print `perldoc $0`;
	exit 1;
}

#####################
# Method prototypes #
#####################

#################
# Method bodies #
#################

# Main subroutine
sub main()
{
	# create changed message
	my ($e_message) = '';
	my ($o_reports);
	foreach my $lang (@{$LANGUAGES}) {
		$o_reports->{$lang} = '';	
	}	
	
	#load cookies
	print "# create cookie files...\n";
	my ($cookies) = common::save_cookies($SHOPS);
	unless ( defined $cookies ) {
		exit 1;
	}	
	
	# get list of links/products/languages
	print "# process initial products...\n";
	my ($xls_parser) = Spreadsheet::ParseExcel->new();
	my ($xls_workbook) = $xls_parser->parse($INIT_EXT_FILE);
	unless ( defined $xls_workbook ) {
		exit 1;
	}
	foreach my $worksheet ( $xls_workbook->worksheets() )
	{
		my ($row_min, $row_max) = $worksheet->row_range();
		my ($col_min, $col_max) = $worksheet->col_range();
		foreach my $row ( $row_min .. $row_max )
		{			
			# "sku", "category_path", "manufacter_id", "link_en","link_es","link_pt"
			my ($cell);
			my ($i_sku);
			my ($i_cat_path);
			my ($i_man_path);
			my ($i_link_en);
			my ($i_link_es);
			my ($i_link_pt);
			$cell = $worksheet->get_cell($row, 0);
			if ( defined $cell ) { $i_sku = $cell->value() }
			
			$cell = $worksheet->get_cell($row, 1);
			if ( defined $cell ) { $i_cat_path = $cell->value() }
			
			$cell = $worksheet->get_cell($row, 2);
			if ( defined $cell ) { $i_man_path = $cell->value() }
			
			$cell = $worksheet->get_cell($row, 3);
			if ( defined $cell ) { $i_link_en = $cell->value() }
			
			$cell = $worksheet->get_cell($row, 4);
			if ( defined $cell ) { $i_link_es = $cell->value() }
			
			$cell = $worksheet->get_cell($row, 5);
			if ( defined $cell ) { $i_link_pt = $cell->value() }
			
			if ( defined $i_sku and defined $i_link_en and defined $i_link_es and defined $i_link_pt ) {
				my ($i_prod) = {
					'sku'				=> $i_sku,
					'category_id'		=> $i_cat_path,
					'manufacturer_id'	=> $i_man_path,
					'lang'				=> {
						$LANGUAGES->[0]	=> $i_link_en,
						$LANGUAGES->[1]	=> $i_link_es,
						$LANGUAGES->[2]	=> $i_link_pt
					}
				};
				print "## product > \n".Dumper($i_prod)."\n";
								
				my ($logger,$o_report);
				my ($shop_name) = 'sportsdirect';
				if ( index($i_link_en, $shop_name) != -1 ) {
					print "### prepare workspace $shop_name\n";
					my ($tmp_dir)	= $SHOP_TMP_DIR->{$shop_name};
					my ($prod_tmp_dir)	= $SHOP_PROD_IMG_DIR->{$shop_name};				
					common::prepare_wspace($tmp_dir);
					common::prepare_wspace($prod_tmp_dir);
					
					print "### checking $shop_name\n";
					($logger,$o_report) = sportdirect::down_product($i_prod);
				}
				else {
					my ($shop_name) = 'lovell-rugby';
					#print "### checking $shop_name\n";
					#if ( index($i_link_en, $shop_name) != -1 ) {
					#	my ($e_msg) = lovellrugby::down_product($i_links, $cookies->{$shop_name});
					#	$e_message .= "$e_msg\n";
					#}
				}
print STDERR "\n\n\n";
print STDERR "LOGGER:\n".Dumper($logger)."\n";
print STDERR "RESULTS:\n".Dumper($o_report)."\n";
				if ( defined $o_report ) {
					foreach my $lang (@{$LANGUAGES}) {
						if ( exists $o_report->{$lang} and ($o_report->{$lang} ne '') ) {
							$o_reports->{$lang} .= $o_report->{$lang};	
						}
					}
				}
				if ( defined $logger ) {
					my ($i_id) = $i_sku;
					my ($i_name) = $i_sku;
					if ( $logger->{'error'} == 1 ) {
						$e_message .= "# $i_id > $i_name [PROBLEMS]\n";
						$e_message .= $logger->{'log'}."\n";
						next; # jump to the next product
					}
					if ( $logger->{'warning'} == 1 ) {
						$e_message .= "# $i_id > $i_name\n";
						$e_message .= $logger->{'log'}."\n";
					}				
				}
			}
		}
	}
	
	print "###########################################################\n\n";
	print "$e_message\n";
	
	#create stock report
	if ( defined $o_reports ) {
		
		# create update file
		print "## printing files\n";
		my ($import_prod_files) = sportdirect::print_prod_result($o_reports, $IMPORT_EXT_PROD_FILE);
		unless (defined $import_prod_files and ($import_prod_files ne '') ) {
			print "ERROR!!! Printing files\n";
		}
		# send email
		my ($import_files) = join(';',$import_prod_files);
		print "## sending files: $import_files\n";
		if ( defined $import_files ) {
			common::send_email($EMAILS_FROM, $EMAILS_TO, $EMAILS_INSERT_SUBJECT, $e_message, $import_files);
		}
	}	

	exit 0;
}

main();


__END__

=head1 NAME

download_external_products

=head1 DESCRIPTION

Script that download the description and images of external products. These items come from a initial list. 

=head1 ARGUMENTS

=head2 Required arguments:
	
	<Type of input: file that contains the clothes>

=head1 EXAMPLE

perl download_external_products.pl initExtStock.csv

=head1 AUTHOR

Created and Developed by

	Jose Manuel Rodriguez Carrasco -josemrc@cnio.es-

=cut
