let
  user1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILx1G6WZ4MQ8c4hUZy2Be+GF5fZQJSssn4qnJoQ4MPxz";
  user2 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGT/WxAzpXRNz4AInl2lvZtegbKW0mZxzJjmMcAy1iOx";
  users = [
    user1
    user2
  ];

  cosmos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOW2nl7vmnVVqb03KCiVHbhGmvdeyMLYIIFVsfvX3xsQ";
  nova = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA4Sgn2sPpoVG1nAIZfS0bwmWRZyfKgsoymFzOt1pp0G";
  systems = [
    cosmos
    nova
  ];
in
{
  "tsauthkey.age".publicKeys = users ++ systems;
}
