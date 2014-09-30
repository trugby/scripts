package CONSTANT;

use strict;
use warnings;

use vars qw(
	$EMAILS_FROM
	$EMAILS_TO
	$EMAILS_CC
	$EMAILS_CHECK_SUBJECT
	$EMAILS_INSERT_SUBJECT
	
	$GD_FILE
	
	$MAIN_LANG
	$LANGUAGES

	$SCRIPT_DIR
	$DATA_DIR
	$TMP_DIR
	$PRODUCT_IMG_DIR
	$PRODUCT_IMG_PATH
	
	$INIT_EXT_FILE
	$UPDATE_EXT_FILE
	$IMPORT_EXT_PROD_FILE
	$EXPORT_PRICESIZESTOCK_PROD_FILE
	$IMPORT_PRICESIZESTOCK_PROD_FILE
	
	$DOWNN_SCRIPT_FILE
	$CHECK_SCRIPT_FILE
	$CSVI_CRON_FILE
	
	$VM_PRODDETAILS_URL
	
	$SHOPS
	$SHOP_COOKIES
	$SHOP_TMP_DIR
	$SHOP_PROD_IMG_DIR
	$SHOP_PROD_IMG_PATH
	$SHOP_CONV_SIZES
	
	$CF_DELIVERY_10_14_TITLE
	$CF_DELIVERY_10_14_VAL
	$CF_CHOOSE_SIZES_TITLE
	$CF_CHOOSE_SIZES_VAL
	$CF_PRODUCTS_INIT_TITLE
	$CF_PRODUCTS_INIT_VAL
	$CF_SIZE_TITLE
	
	$CONV_CATEGORY_IDS
	$PROD_AVAILABILITY
);

$EMAILS_FROM				= 'admin@insitusports.com';
$EMAILS_TO					= 'insitusports@gmail.com';
$EMAILS_CC					= 'josemrc@gmail.com';
$EMAILS_CHECK_SUBJECT		= '[InSiS Stock]: Checking Products';
$EMAILS_INSERT_SUBJECT		= '[InSiS Stock]: Inserting Products';

$GD_FILE			= 'https://docs.google.com/uc?id=0Bw3YSiAszMkTaGpza1VLVEQzUzA&export=download';

$MAIN_LANG			= 'en';
$LANGUAGES			= ['en','es','pt'];

$SCRIPT_DIR			= '/kunden/homepages/24/d406245370/htdocs/scripts/stock';
$DATA_DIR			= '/kunden/homepages/24/d406245370/htdocs/data/stock';
$TMP_DIR			= '/kunden/homepages/24/d406245370/htdocs/tmp/stock';
$PRODUCT_IMG_DIR 	= '/kunden/homepages/24/d406245370/htdocs/beta/images/stories/virtuemart/product';
$PRODUCT_IMG_PATH 	= '';
#$SCRIPT_DIR			= '/Users/jmrodriguez/Google\ Drive/Stock/scripts/stock';
#$DATA_DIR			= '/Users/jmrodriguez/tmp';
#$TMP_DIR			= '/Users/jmrodriguez/tmp';
#$PRODUCT_IMG_DIR 	= '/Users/jmrodriguez/tmp';
#$PRODUCT_IMG_PATH 	= '';

#$INIT_EXT_FILE			= $DATA_DIR.'/../initExtStock.csv'; # NOT USED
$IMPORT_EXT_PROD_FILE	= $DATA_DIR.'/ImportExternalStock__LANG__.csv';
$EXPORT_PRICESIZESTOCK_PROD_FILE	= $DATA_DIR.'/ExportPriceSizeStockProducts.csv';
$IMPORT_PRICESIZESTOCK_PROD_FILE	= $DATA_DIR.'/ImportPriceSizeStockProducts.csv';

$DOWNN_SCRIPT_FILE		= $SCRIPT_DIR.'/download_external_products.pl';
$CHECK_SCRIPT_FILE		= $SCRIPT_DIR.'/check_external_stock.pl';
$CSVI_CRON_FILE			= '/kunden/homepages/24/d406245370/htdocs/beta/administrator/components/com_csvi/helpers/cron.php';

$VM_PRODDETAILS_URL		= 'https://insitusports.com/index.php?option=com_virtuemart&view=productdetails';

############################
# GLOBAL VARIABLES OF SHOP #
############################

$SHOPS 				= {
	'sportsdirect' => {
		'link'	=> 'http://www.sportsdirect.com/'
	},
	'lovell-rugby' => {
		'link'	=> 'http://www.lovell-rugby.co.uk',
	}
};
$SHOP_COOKIES 		= {
	'sportsdirect' => $TMP_DIR.'/cookies_sportsdirect.txt',
	'lovell-rugby' => $TMP_DIR.'/cookies_lovell-rugby.txt',
};
$SHOP_TMP_DIR	= {
	'sportsdirect' => $TMP_DIR.'/sportsdirect',
	'lovell-rugby' => $TMP_DIR.'/lovell-rugby',
};
$SHOP_PROD_IMG_DIR	= {
	'sportsdirect' => $PRODUCT_IMG_DIR.'/sportsdirect',
	'lovell-rugby' => $PRODUCT_IMG_DIR.'/lovell-rugby',
};
$SHOP_PROD_IMG_PATH	= {
	'sportsdirect' => $PRODUCT_IMG_PATH.'/sportsdirect',
	'lovell-rugby' => $PRODUCT_IMG_PATH.'/lovell-rugby',
};
$SHOP_CONV_SIZES	= {
	'sportsdirect' => {
			
			# clothing sizes
			'junior'	=> 'XS',
			'extrasml'	=> 'XS',
			'small'		=> 'S',
			'medium'	=> 'M',
			'large'		=> 'L',
			'extralge'	=> 'XL',
			'xxlarge'	=> '2XL',
			'xxxlarge'	=> '3XL',
			'xxxxlarge'	=> '4XL',	
			'sml/med'	=> 'S/M',
			'lge/xlge'	=> 'L/XL',
			
			# boxing gloves
			'8oz'		=> '8OZ',
			'10oz'		=> '10OZ',
			'12oz'		=> '12OZ',
			'14oz'		=> '14OZ',
			'16oz'		=> '16OZ',
			'18oz'		=> '18OZ',
			
			# shoes sizes
			'6'			=> '6',
			'6.5'		=> '6.5',
			'7'			=> '7',
			'7.5'		=> '7.5',
			'8'			=> '8',
			'8.5'		=> '8.5',
			'9'			=> '9',
			'9.5'		=> '9.5',
			'10'		=> '10',
			'10.5'		=> '10.5',
			'11'		=> '11',
			'11.5'		=> '11.5',
			'12'		=> '12',
			'12.5'		=> '12.5',
			'13'		=> '13',
			'13.5'		=> '13.5',
			
			'n'			=> 'N',
			
			# clothing junior sizes
			'7-8(xsb)'	=> 'XSB',
			'7-8(sb)'	=> 'SB',
			'6-7yrs'	=> 'SB',
			'7-8yrs'	=> 'SB',
			'9-10(mb)'	=> 'MB',
			'9-10yrs'	=> 'MB',
			'11-12(lb)'	=> 'LB',
			'11-12yrs'	=> 'LB',
			'13(xlb)'	=> 'XLB',
			'13yrs'		=> 'XLB',

			# ball sizes
			'size5'		=> '5',			
	},
	'lovell-rugby' => {
		
	},
};

# Custom Fields
$CF_DELIVERY_10_14_TITLE = 'COM_VIRTUEMART_CUSTOM_FIELDS_TIME_DELIVERY_10_14_TITLE';
$CF_DELIVERY_10_14_VAL = 'COM_VIRTUEMART_CUSTOM_FIELDS_TIME_DELIVERY_10_14_VALUE';
$CF_CHOOSE_SIZES_TITLE = 'COM_VIRTUEMART_CUSTOM_FIELDS_CHOOSE_SIZES_TITLE';
$CF_CHOOSE_SIZES_VAL = 'COM_VIRTUEMART_CUSTOM_FIELDS_CHOOSE_SIZES_VALUE';
$CF_PRODUCTS_INIT_TITLE = $CF_DELIVERY_10_14_TITLE.'~'.$CF_CHOOSE_SIZES_TITLE;
$CF_PRODUCTS_INIT_VAL = $CF_DELIVERY_10_14_VAL.'~'.$CF_CHOOSE_SIZES_VAL;
$CF_SIZE_TITLE = 'COM_VIRTUEMART_CUSTOM_FIELDS_SIZE_TITLE';

$PROD_AVAILABILITY = '14d.gif';

$CONV_CATEGORY_IDS = {
	
};





1;