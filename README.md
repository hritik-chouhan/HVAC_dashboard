# Hvac

A Flutter based HVAC application made for AGL IVI dashboard, connected with KUKSA.VAL server.

## Screenshot



:![Hvac_ui](https://user-images.githubusercontent.com/76897843/177274160-42189106-730e-4aa0-8770-90f6403e3944.PNG)

To run this app, we need Flutter SDK, KUKSA server and config.YAML file

#Steps to run the app

- Run KUSKA.VAL server. For more details, checkout [KUKSA.VAL](https://github.com/eclipse/kuksa.val/tree/master/kuksa-val-server)

- Install the kuksa_viss_client. Follow [KUKSA_VISS_CLIENT](https://github.com/eclipse/kuksa.val/tree/master/kuksa_viss_client)

- Connect to server, authorize.

- Create a config.YAML file.

- Update the path of file in the source code. [update this](https://github.com/hritik-chouhan/HVAC_dashboard/blob/main/lib/config.dart#L25)

- Go to the project directory

- First run flutter create .

- Then to run the app flutter run

