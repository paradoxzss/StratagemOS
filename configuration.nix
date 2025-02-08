
# PARADOXzss07 NixOS Conf

{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];


#  ___           _   _              _         
# | _ ) ___  ___| |_| |___  __ _ __| |___ _ _ 
# | _ \/ _ \/ _ \  _| / _ \/ _` / _` / -_) '_|
# |___/\___/\___/\__|_\___/\__,_\__,_\___|_|  

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-0056d679-2d11-464b-91a8-8d3a03f67c19".device = "/dev/disk/by-uuid/0056d679-2d11-464b-91a8-8d3a03f67c19";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

#  _  _     _                  _   _           
# | \| |___| |___ __ _____ _ _| |_(_)_ _  __ _ 
# | .` / -_)  _\ V  V / _ \ '_| / / | ' \/ _` |
# |_|\_\___|\__|\_/\_/\___/_| |_\_\_|_||_\__, |
#                                        |___/ 
  networking.hostName = "NixOS";
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true; # WPA supplicant


#  _                 _        
# | |   ___  __ __ _| |___ ___
# | |__/ _ \/ _/ _` | / -_|_-<
# |____\___/\__\__,_|_\___/__/

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


#  ___  _         _           
# |   \(_)____ __| |__ _ _  _ 
# | |) | (_-< '_ \ / _` | || |
# |___/|_/__/ .__/_\__,_|\_, |
#           |_|          |__/ 

  # Enable the X11 windowing system.
    services.xserver.enable = true;

  # Enable GDM & GNOME
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

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

  #Enable the Hyprland WM (WIP)
   programs.hyprland = {
   enable = true; 
   xwayland.enable = true;
  };

  # Hint Electon apps to use wayland
   environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
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

#    _          _ _     
#   /_\ _  _ __| (_)___ 
#  / _ \ || / _` | / _ \
# /_/ \_\_,_\__,_|_\___/

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

#  ___         _             
# / __|_  _ __| |_ ___ _ __  
# \__ \ || (_-<  _/ -_) '  \ 
# |___/\_, /__/\__\___|_|_|_|
#      |__/                  

  # Enable touchpad support (enabled default in most desktopManagers).
  services.libinput.enable = true;

#  _   _                                       _   
# | | | |___ ___ _ _   __ _ __ __ ___ _  _ _ _| |_ 
# | |_| (_-</ -_) '_| / _` / _/ _/ _ \ || | ' \  _|
#  \___//__/\___|_|   \__,_\__\__\___/\_,_|_||_\__|
  
users.users.paradoxzss = {
    isNormalUser = true;
    description = "PARADOXzss";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "dialout" ];
    packages = with pkgs; [
    ];
  };

	services.fprintd.enable = true;

	services.fprintd.tod.enable = true;

	services.fprintd.tod.driver = pkgs.libfprint-2-tod1-vfs0090;

#  ___ _                  
# / __| |_ ___ __ _ _ __  
# \__ \  _/ -_) _` | '  \ 
# |___/\__\___\__,_|_|_|_|

		programs.steam.enable = true;
#  ___ _          __         
# | __(_)_ _ ___ / _|_____ __
# | _|| | '_/ -_)  _/ _ \ \ /
# |_| |_|_| \___|_| \___/_\_\
		  programs.firefox.enable = true;


#  ___ _    _       _____ _        _ ___  
# | __(_)__| |_    / / __| |_  ___| | \ \ 
# | _|| (_-< ' \  | |\__ \ ' \/ -_) | || |
# |_| |_/__/_||_| | ||___/_||_\___|_|_|| |
#                  \_\                /_/ 
		  programs.fish.enable = true;


#  _   _       __                             _                    
# | | | |_ _  / _|_ _ ___ ___   _ __  __ _ __| |____ _ __ _ ___ ___
# | |_| | ' \|  _| '_/ -_) -_) | '_ \/ _` / _| / / _` / _` / -_|_-<
#  \___/|_||_|_| |_| \___\___| | .__/\__,_\__|_\_\__,_\__, \___/__/
#                              |_|                    |___/        
  		nixpkgs.config.allowUnfree = true;

#     ____             __                        
#    / __ \____ ______/ /______ _____ ____  _____
#   / /_/ / __ `/ ___/ //_/ __ `/ __ `/ _ \/ ___/
#  / ____/ /_/ / /__/ ,< / /_/ / /_/ /  __(__  ) 
# /_/    \__,_/\___/_/|_|\__,_/\__, /\___/____/  
#                             /____/             
  environment.systemPackages = with pkgs; [

	# System ( Required )
 	fish
	st
	dmenu
	picom

	# System ( Non-critical )
	wofi
	waybar
	gparted
	dolphin
	hyprland
	p7zip
	cava
	dunst
	libnotify
	rofi-wayland
	arandr
	pavucontrol
	kvmtool
	gnome-tweaks
	gnupg
	fprintd
	
	# Terminal & terminal tools
	cool-retro-term
	kitty
    	fastfetch
	onefetch
  	btop
	hyfetch
	brightnessctl
    	wget
    	git
    	gcc
    	neovim
	cbonsai
	sl
	lavat
	figlet
	cmatrix
	cowsay


	# Programming/coding & langs
	jetbrains.clion
	python312
    	openjdk8
    	openjdk17
	cargo
	rustc
	rustup
	vscodium
	gnome-boxes

	# FS Progs
	btrfs-progs
	exfatprogs

	# Games
    	prismlauncher
	lutris
	wine
	superTuxKart
	superTux
	chess-tui
	stockfish

	# Entertainment & media
    	spotify
	vlc
	rockbox-utility
	jellyfin	

	# Creation & productivity
    	krita
	libreoffice
	aseprite
	bambu-studio

	# Fonts, themes, and theming
	nerdfonts
	jetbrains-mono
	gnome-icon-theme
	catppuccin
	font-awesome
	catppuccin-cursors.mochaDark
	gruvbox-dark-gtk
	hyprpaper

	# Torrenting stuff
	qbittorrent
	torctl
	tor-browser

	# Communication
	discord
	
	# Documentation and storage
	kiwix
 	 ];

  system.stateVersion = "24.11";
}
