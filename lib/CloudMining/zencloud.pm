require WWW::Mechanize;
require Data::Dumper qw( Dumper);
require JSON qw( to_json);
require Web::Scraper;
require App::CloudMining;

package CloudMining::zencloud;

  use WWW::Mechanize;
  use Data::Dumper qw( Dumper);
  use JSON qw( to_json);
  use Web::Scraper;
  use MooseX::App::Command; # important
  extends qw(App::CloudMining); # purely optional, only if you want to use global options from base class
  app_base 'CloudMining'; # Defaults to $0

    parameter 'username' => (
        is            => 'rw',
        isa           => 'Str',
        required      => 1,
        documentation => q[Username for login],
        cmd_tags          => [qw(Important!)], # Extra tags. Displayed in square brackets
        cmd_aliases       => [qw(u)], # Alternative option name      
    ); # Positional parameter
    
    parameter 'password' => (
        is            => 'rw',
        isa           => 'Str',
        required      => 1,
        documentation => q[Password for login],
        cmd_tags          => [qw(Important!)], # Extra tags. Displayed in square brackets
        cmd_aliases       => [qw(p)], # Alternative option name      
    ); # Positional parameter

    option 'as_csv' => (
        is            => 'rw',
        isa           => 'Bool',
        default       => 1,
        documentation => q[ Print as csv],
    ); # Option
    
    option 'show_miner' => (
        is            => 'rw',
        isa           => 'Bool',
        default       => 0,
        documentation => q[ Verbose miner stat's output ],
        cmd_aliases       => [qw(s)], # Alternative option name      
       
    ); # Option
    
    
  command_short_description q[ zencloud stats];

  command_long_description q[ zecloud api commands ];

   sub printexit {
       my ($self,@arr) = @_;
   
       print to_json($self->{stats})."\n" if ($self->{debug});
        return if ($self->{debug});
        print "Coin,est_payout,power,activated\n" if ($ self->{as_csv} );
        for my $tweet (@{$self->{stats}->{miner}}) {
            print "$tweet->{coin}\t$tweet->{est_payoutBTC}\t$tweet->{power}\t$tweet->{activated}\n" if ($self->{as_csv} );
        }           
   
   }
   
   
  sub run {
      my ($self,@arr) = @_;
      my $username = $self->{username};
      my $password = $self->{password};
      my $return = {};

      print "--> Login : $username\r\n" if ($self->{debug});
        use WWW::Mechanize;
        my $get = WWW::Mechanize->new();
         $get->get("https://cloud.zenminer.com/");
         $get->set_visible( $username, $password );
         $get->click();
         
         
        $self->{stats} = get_default_stats($get);
        $self->printexit("test") if not ($self->{show_miner});
        $self->{miner} = ();
        
        $self->{stats}->{feeUSD} = 0;
        $self->{stats}->{btc24hPayout_est} = 0;
        foreach(get_miner_stats($get)){
                my $miner = $_;
                $self->{stats}->{btc24hPayout_est} =  ($self->{stats}->{btc24hPayout_est}+$miner->{est_payoutBTC});
                $self->{stats}->{feeUSD} = ($self->{stats}->{feeUSD}+$miner->{feeUSD}); 
                push(@{$self->{stats}->{miner}},$miner);
        }
        
        
        
    #print Data::Dumper::Dumper($_)."\n";            

        $self->printexit("test");
        #$return = get_miner_stats($get);
        #print Data::Dumper::Dumper($return)."\n";
        
        
      #   $get->save_content("temp.html");
         #print "----------\n".Data::Dumper::Dumper($scrap->scrape($get->content()))."\n";
        #my $show_coins = $self->{coins} || '3';
        #$self->get("https://cloud.zenminer.com/ajax/miners");

      
  }


  
  sub get_miner_stats(){
        my $get = shift or die("error with get");
        $get->get("https://cloud.zenminer.com/ajax/miners");
        my $scrap =  scraper {
            
            process "div.device", "list[]"  => scraper {
                process ".name", name => 'TEXT';
                process ".power", power => 'TEXT';
                #process "a",  power_fix => '@data-device-power';
                #process "a",  pool => '@data-pool';
                process ".payout", est_payoutBTC => 'TEXT';
                process ".device",  feeUSD => '@data-dailyamount';
                process ".device",  activated => '@data-activated';
                process ".device",  sellprice => '@data-sellprice';
                process ".device",  coin => '@data-type';
            };
        };
        #my $res = $scrap->scrape($get->content);
        return @{$scrap->scrape($get->content)->{list}};

    
  }
  
  sub get_default_stats(){
        my $get = shift or die("error with get");
        my $scrap =  scraper {
            process ".balance-value", btc_deposit => 'TEXT';
            process ".balanceUSD-value", btcUSD => 'TEXT';
            process ".btcAddress", btc_addr => 'TEXT';
            process ".24hPayout", btc24hPayout => 'TEXT';
            process ".totalScryptHashpower", totalScryptHashpower => 'TEXT';
            process ".totalBtcHashpower", totalBtcHashpower => 'TEXT';

        };
        return $scrap->scrape($get->content);    
        
    
  }

  #  sub do_some { print "Hello World @_\n" }

  
  # ABSTRACT: Shows Miner stats on zencloud as json or csv


    
1;

