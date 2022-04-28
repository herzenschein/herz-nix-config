{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  #==== Packages ====#
  environment.systemPackages = with pkgs; [
    firefox kate neofetch fish czkawka samba open-dyslexic
  ];

  #==== Desktop ====#

  #1111 PLASMA     1111#
  users.users.blumen = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };
  services.xserver.enable = true;
  #services.xserver.displayManager.sddm.enable = true;
  #services.xserver.displayManager.sddm.settings =
  #{
  #  Default =
  #  {
  #    DisplayServer = "wayland";
  #  };
  #};
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.displayManager.defaultSession = "plasmawayland";
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.desktopManager.plasma5.runUsingSystemd = true;
  #services.xserver.displayManager.autoLogin.enable = true;
  #services.xserver.displayManager.autoLogin.user = "blumen";
  xdg.portal.enable = true;
  xdg.portal.gtkUsePortal = true;
  services.xserver.libinput.enable = true;
  services.power-profiles-daemon.enable = true;
  programs.kdeconnect.enable = true;


  #2222 LOCALE     2222#
  i18n.defaultLocale = "pt_BR.UTF-8";
  console =
  {
    #font = "OpenDyslexicAlta";
    keyMap = "br-abnt2";
  };
  services.xserver.layout = "br";
  services.xserver.xkbVariant = "abnt2";

  
  #3333 SOUND      3333#
  sound.enable = true;
  services.pipewire.enable = true;
  services.pipewire.wireplumber.enable = true;
  services.pipewire.pulse.enable = true;

  
  #4444 NETWORKING 4444#
  networking.networkmanager.enable = true;
  networking.domain = "lapinetop";
  networking.useDHCP = false;
  networking.interfaces.enp3s0.useDHCP = true;
  networking.interfaces.wlp2s0.useDHCP = true;
  networking.networkmanager.wifi.powersave = false;

  services.localtime.enable = true;

  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  services.avahi.publish.enable = true;
  services.samba-wsdd.enable = true;
  services.samba-wsdd.discovery = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  #services.sshd.enable = true;

  services.gitea.enable = true;
  services.gitea.httpPort = 80;
  services.gitea.useWizard = true;
  #services.gitea.domain = "localhost";
  #services.gitea.httpAddress = "###.##.##.#";


  #5555 HARDWARE   5555#
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}

