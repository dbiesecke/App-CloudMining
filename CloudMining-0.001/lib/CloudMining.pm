#!/usr/bin/perl
require App::FatPacker;
require Data::Dumper;
require Dist::Zilla;
require ExtUtils::MakeMaker;
require JSON;
require LWP::Simple::REST;
require Moose;
require Moose::Role;
require MooseX::App;
require MooseX::App::Command;
require Web::Scraper;
require WWW::Mechanize;
require IO::Interactive;


package CloudMining;

    # base class of this(Arithmetic) module

  
    use MooseX::App qw(BashCompletion ConfigHome Color Version  );
    #
    option 'debug' => (
        is            => 'rw',
        isa           => 'Bool',
        documentation => q[set Debug mode for verbose ],
    ); # Global option

    option 'verbose' => (
        is            => 'rw',
        isa           => 'Bool',
        documentation => q[set verbose to show more stats],
    ); # Global option

    
    has 'private' => ( 
        is              => 'rw',
    ); # not exposed
    


    #
    #
    #sub new()
    #{
    #        my ($class) = @_;
    #        my $self = {};
    #        
    #        $self{config} = ();
    #        
    #        print Data::Dumper::Dumper($self{config})."\n";
    #        
    #        return bless $self,$class;
    #
    #}
    #
    #sub config()
    #{
    #        #confess "usage: read->readfile(keyvalue)"    unless @_ => 2;
    #        my ($self,$key,$val) = @_;
    #        print Data::Dumper::Dumper($self{config})."\n";
    #        $self{config} = { $key => $val};
    #        print Data::Dumper::Dumper($self{config})."\n";
    #
    #        return $self;
    #
    #}
    #
    #
    #
    #sub dd(){
    #    my ($self) = @_;
    #    
    #    print Data::Dumper::Dumper($self{config})."\n";
    #
    #    my $ps  =   Plugin::Tiny->new (  prefix=>'Spammer::Plugin::' ); 
    #    
    #    for (@My::Hotpatch::EXPORT) {
    #      print "$_\n";
    #    }
    #    
    #}
    #
    #eval {
    #    use autodie qw(system);
    #    system(`backup_files`);
    #    system(`delete_files`);
    #};
    #if ($@) {
    #    warn "Error in running commands: $@\n";
    #}

1;

    # ABSTRACT: Shows up differents stats from BTC or Scrypt Cloud Mining Providers

