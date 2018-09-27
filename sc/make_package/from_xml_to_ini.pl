#/usr/bin/perl
my($xmlfile) = @ARGV;
open(FH,$xmlfile) ||  die "this file does not exist! $! \n";
@items = <FH>;
open(PACFH,'>pac.ini') || die "error $!";
print  PACFH "[Setting] \n";

$IDflag =  1;
foreach $item (@items)
{
        if ($item =~  /<FlashTypeID>(.*)<\/FlashTypeID>/ig )
        {
                print  PACFH  "NandFlash=$1"."\n";
                if  ( defined($pac_product) )
                {
                        print  PACFH "PAC_PRODUCT=$pac_product"."\n";
                }
                else
                {
                        print  "pac_product is not defined !!  please check your  xml file"."\n";
                        exit  1;
                }
                print  PACFH "PAC_CONFILE="."\n";
        }
        if ( $item =~ /Product\s+name="(.*)"/ig )
        {
                $pac_product=$1;
        }
        if ( $item =~ /<SchemeList>/ig )
        {
                print "start  to get PacParm ..........."."\n";
                print PACFH "\n\n[PacParam]\n";
                $PacFlag=1;
        }
        if ( $PacFlag  ==  1 )
        {
		if (  $item =~  /<!--/ig  )
		{
			$IDflag  = 0;
		}
		if  ( $IDflag ==  0 )
		{
			if  (  $item =~  /-->/ig )
			{
				$IDflag = 1;
			}
		}
	        if  (  $IDflag ==  1 )
		{
                	if (  $item =~ /<ID>(.*)<\/ID>/ig )
                	{
                        	$idparm =  $1;
                	}
                	if ( $item =~  /<Flag>(.*)<\/Flag>/ig )
                	{
                        #print  PACFH "$idparm=$1@."."\n";
                        print  PACFH "$idparm=1@."."\n";
                	}
		}
        }
 }

