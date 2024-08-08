let
  main = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILx1G6WZ4MQ8c4hUZy2Be+GF5fZQJSssn4qnJoQ4MPxz";
  alt = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGT/WxAzpXRNz4AInl2lvZtegbKW0mZxzJjmMcAy1iOx";
  users = [
    main
    alt
  ];

  cosmos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJLP1aahIQ3NxtO6D7fMLzFT91xjCASrAlmHPIxEaVRT";
  nebula = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH0oDlwxn0cKRuNrpb0neWGczQzQbQbX8fPkvc1zIcwe";
  nova = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA4Sgn2sPpoVG1nAIZfS0bwmWRZyfKgsoymFzOt1pp0G";
  vortex = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO2aT32IeITZcrNPSbZnrtbRqRdekmVr42sLHw6IL/h1";
in
{
  "tailscale/cosmos.age".publicKeys = users ++ [ cosmos ];
  "users/cosmos.age".publicKeys = users ++ [ cosmos ];

  "tailscale/nebula.age".publicKeys = users ++ [ nebula ];

  "cifs/nova.age".publicKeys = users ++ [ nova ];
  "samba/nova.age".publicKeys = users ++ [ nova ];

  "tailscale/vortex.age".publicKeys = users ++ [ vortex ];
  "users/vortex.age".publicKeys = users ++ [ vortex ];
}
