{ config, pkgs, lib, ... }:

let
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-enviroment";
    executable = true;

    text = ''
      dbus-update-activation-enviroment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };

  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure/-gtk";
    executable = true;
    text =
      let
        schema = pkgs.gsettings-desktop-schemas;
        datadir = "${schema}/share/gsetting-schemas/${schema.name}";
      in
      ''
        export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
        gnome_schema=org.gnome.desktop.interface
        gsettings set $gnome_schema gtk-theme 'WhiteSur-dark'
        gsettings set $gnome_schema cursor-theme 'capitaine-cursors-white'
      '';
  };

in
{
  environment.systemPackages = with pkgs; [
    wezterm
    sway
    dbus-sway-environment
    configure-gtk
    wayland
    xdg-utils
    glib
    whitesur-icon-theme
    grim
    slurp
    wl-clipboard
    capitaine-cursors
    mako
    autotiling-rs
    swayidle
    swaylock
    swaybg
    rofi
    wob
    playerctl
    waybar
    brightnessctl
    copyq
    pavucontrol
  ];

  programs.thunar.enable = true;
  services.dbus.enable = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet -r --time --cmd sway";
        user = "tcrha";
      };
    };
  };
}

