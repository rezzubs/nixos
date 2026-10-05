{...}: {
  users.users = {
    harshit = {
      isNormalUser = true;
      description = "Harshit Gupta";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBBUnYbIv10UZRh2JSBXl+hyAfu6IRrvX03+tJh59NJM harshit.gupta@taltech.ee"
      ];
    };

    kyrylo = {
      isNormalUser = true;
      description = "Kyrylo Nazarevych";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGrZzZR59e+RaDx96gmSXlTg28Lu29Y3Tuj6QaH4pyi1 kyrylo.nazarevych@taltech.ee"
      ];
    };

    mojtaba = {
      isNormalUser = true;
      description = "Mohammad Hasan (Mojtaba) Ahmadilivani";
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC4JeTW8RpjVZftoW7lArHbfTzLXI2oUeZMXzwXsKeR9+Bd33wA+9KXWF1uMhwKttNcUE/Uh3079T9irm2wQ+zO1s5bI67zzgXCV4/KlLl4tlrKJSiUpNCmK7ExdNJWlf91FUpx/Fi/8Qygieh9N97YE7GpfLBpk6NOEbe7Wl721Pz5SZyM4CZY0M4ZjzAyiq2/uKqjVg7R1IlczBLVHBGr5UM6tQ68N5tziK6Gj23IPLbFNEf3YsU4Rscpmc+qKjGBQgf1AoAhoXOuuRXTAH30qxObd2EWo0gR8KO0FZdJJj6evLTVZmPDXuRzpVP+Dq7t/kQKJqPsf7VdFUT6xPGU7J0EVw8hNeaOWpAwZviY2EJWAENPK8ngz5IVRNmFWdWmG9EUO9x7PZsekIjrIn9y41fa2ZLLF/BY+Umc+zajqIv/k/q94fvo0/vf3lodWv8+wtO3f/mZoZKMvzzwbizc87mNfxa9qB8WSf3iaC+vDn4b7YuLH9d7TFMxa7EzwTM= mojtaba@krevett"
      ];
    };

    samiel = {
      isNormalUser = true;
      description = "Sven-Markus Loorits";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFjlJjHkFg0HoYZSwHzZY/O2Llfo3931SGoFv+26PtoU rex.samiel@gmail.com"
      ];
    };
  };
}
