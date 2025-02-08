# StratagemOS conf

{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

# Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-0056d679-2d11-464b-91a8-8d3a03f67c19".device = "/dev/disk/by-uuid/0056d679-2d11-464b-91a8-8d3a03f67c19";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

# Networking
  networking.hostName = "NixOS";
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true; # WPA supplicant


# Locales
  # Set your time zone
  time.timeZone = "America/New_York";

  # Select internationalisation properties
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };


# Display
  # Enable the X11 windowing system.
    services.xserver.enable = true;

  # Enable GDM
  services.xserver.displayManager.gdm.enable = true;

  # Enable DWM + Ricing
   services.xserver.windowManager.dwm = {
   enable = true;
   package = pkgs.dwm.overrideAttrs {
     src = ./dwm;
   };
 };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Screen sharing
   services.dbus.enable = true;
   xdg.portal = {
   enable = true;
   wlr.enable = true;
   extraPortals = [
   pkgs.xdg-desktop-portal-gtk
  ];
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

# Audio
  # Enable sound with pipewire.
  #hardware.pulseaudio.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
    };

# System              
  # Enable touchpad support (enabled default in most desktopManagers).
  services.libinput.enable = true;

#  User acc
  
users.users.paradoxzss = {
    isNormalUser = true;
    description = "INSERT_NAME_HERE";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "dialout" ];
    packages = with pkgs; [
    ];
  };

# Finger print reading
services.fprintd.enable = true;
services.fprintd.tod.enable = true;
services.fprintd.tod.driver = pkgs.libfprint-2-tod1-vfs0090;


# Enable some packages
programs.steam.enable = true;
programs.firefox.enable = true;
programs.fish.enable = true;

nixpkgs.config.allowUnfree = true;

environment.systemPackages = with pkgs; [

	# System ( Required )
 	fish
	st
	dmenu
	picom

	# System ( Non-critical )
	gparted
	dolphin
	p7zip
	arandr
	pavucontrol
	kvmtool
	gnupg
	fprintd
	
	# Terminal & terminal tools
	cool-retro-term
    	fastfetch
	onefetch
  	btop
	hyfetch
	brightnessctl
    	wget
    	git
    	gcc
	neovim


	# Programming/coding & langs
	python312
    	openjdk8
    	openjdk17
	cargo
	rustc
	rustup
	vscodium

	# FS Progs
	btrfs-progs
	exfatprogs

	# Games
    	prismlauncher
	lutris
	wine

	# Entertainment & media
    	spotify
	vlc
	jellyfin	

	# Creation & productivity


	# Fonts, themes, and theming
	nerdfonts
	jetbrains-mono
	gnome-icon-theme
	catppuccin
	font-awesome
	catppuccin-cursors.mochaDark
	gruvbox-dark-gtk

	# Torrenting stuff
	qbittorrent
	torctl
	tor-browser

	# Communication
	discord
	
	# Documentation and storage
 	 ];

  system.stateVersion = "24.11";
}
