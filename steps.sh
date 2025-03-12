-----------------------------------------------------------------------------------
Loki Installation
-----------------------------------------------------------------------------------
curl -O -L "https://github.com/grafana/loki/releases/download/v3.4.2/loki-linux-amd64.zip"
 apt install unzip -y

unzip loki-linux-amd64.zip
wget https://raw.githubusercontent.com/grafana/loki/main/cmd/loki/loki-local-config.yaml

chmod +x loki-linux-amd64

sudo mv loki-linux-amd64 /usr/local/bin/loki
sudo chmod +x /usr/local/bin/loki

sed -i 's/^\( *enable_multi_variant_queries: true\)/# \1/' loki-local-config.yaml

vi loki-local-config.yaml
# enable_multi_variant_queries: true

http://ip:3100/metrics
./loki-linux-amd64 --config.file=loki-local-config.yaml
sudo vi /etc/systemd/system/loki.service

[Unit]
Description=Loki Log Aggregation System
After=network.target

[Service]
User=root
ExecStart=/usr/local/bin/loki --config.file=/root/loki-local-config.yaml
Restart=always
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target

sudo systemctl daemon-reload
sudo systemctl enable loki
sudo systemctl start loki
sudo systemctl status loki

Install Grafana
sudo apt-get install -y apt-transport-https software-properties-common wget
sudo mkdir -p /etc/apt/keyrings/
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
# Updates the list of available packages
sudo apt-get update -y
# Installs the latest OSS release:
sudo apt-get install grafana

sudo service grafana-server start
sudo service grafana-server status

------------------------------------------------------------------------------------

PROMTAIL INSTALLATION
----------------------
wget https://github.com/grafana/loki/releases/download/v2.8.2/promtail-linux-amd64.zip
 apt install unzip -y
unzip promtail-linux-amd64.zip
sudo mv promtail-linux-amd64 /usr/local/bin/promtail
sudo chmod +x /usr/local/bin/promtail

wget https://raw.githubusercontent.com/grafana/loki/main/clients/cmd/promtail/promtail-local-config.yaml

./promtail-linux-amd64 --config.file=promtail-local-config.yaml
vi promtail-local-config.yaml

Change client ip

sudo vi /etc/systemd/system/promtail.service

[Unit]
Description=Promtail Log Collector for Loki
After=network.target

[Service]
User=root
ExecStart=/usr/local/bin/promtail --config.file=/root/promtail-local-config.yaml
Restart=always
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target

sudo systemctl daemon-reload
sudo systemctl restart promtail
sudo systemctl status promtail

Grafana Installation
https://grafana.com/docs/grafana/latest/setup-grafana/installation/debian/
https://grafana.com/docs/loki/latest/setup/install/local/

{job="varlogs"}  = 'docker'

13186
13639
13332 - kube-state-metrics-v2
10880
12611
20881
sudo apt-get install -y adduser libfontconfig1 musl
wget https://dl.grafana.com/enterprise/release/grafana-enterprise_9.4.0_amd64.deb
sudo dpkg -i grafana-enterprise_9.4.0_amd64.deb

sudo mv /usr/sbin/grafana-server /usr/bin/
grafana-server -v
sudo systemctl restart grafana-server

sudo touch /home/ubuntu/app/course-content/app.log
sudo chown ubuntu:ubuntu /home/ubuntu/app/course-content/app.log
sudo chmod 666 /home/ubuntu/app/course-content/app.log
sudo systemctl restart flaskapp.service

sum by (status) (count_over_time({filename="/home/ubuntu/app/course-content/app.log"} |~ "GET /.* HTTP.* (200|404|500)" [1m]))

count_over_time({job="applogs"}[$__interval])
sum by (status) (count_over_time({filename="/home/ubuntu/app/course-content/app.log"} |~ "GET /.* HTTP.* 200" [1m]))
sum by (status) (count_over_time({filename="/home/ubuntu/app/course-content/app.log"} |~ "GET /.* HTTP.* (404)" [1m]))
sum by (status) (count_over_time({filename="/home/ubuntu/app/course-content/app.log"} |~ "GET /.* HTTP.* 500" [1m]))

Get requests
count_over_time({filename="/home/ubuntu/app/course-content/app.log"} |= "GET" [1m])

count_over_time({filename="/home/ubuntu/app/course-content/app.log"} |= "49.207.214.17" [1m])

CRITICAL|FATAL
{filename="/home/ubuntu/app/course-content/app.log"} |~ "CRITICAL|FATAL"

sudo groupadd --system grafana
sudo useradd --system --no-create-home --shell /sbin/nologin --gid grafana grafana
sudo mkdir -p /var/lib/grafana /var/log/grafana /etc/grafana
sudo chown -R grafana:grafana /var/lib/grafana /var/log/grafana /etc/grafana
sudo chmod -R 755 /var/lib/grafana /var/log/grafana /etc/grafana
sudo touch /etc/grafana/grafana.ini
sudo chown grafana:grafana /etc/grafana/grafana.ini
sudo systemctl daemon-reload
sudo systemctl restart grafana-server
sudo systemctl status grafana-server
sudo vi  /etc/grafana/grafana.ini
[tracing.opentelemetry.otlp]
sudo mv /etc/grafana/grafana.ini /etc/grafana/grafana.ini.bak

sudo vi /etc/systemd/system/grafana-server.service
[Unit]
Description=Grafana instance
After=network.target

[Service]
User=grafana
Group=grafana
Type=simple
ExecStart=/usr/bin/grafana-server --config=/etc/grafana/grafana.ini --homepath=/usr/share/grafana --packaging=deb cfg:default.paths.logs=/var/log/grafana cfg:default.paths.data=/var/lib/grafana cfg:default.paths.plugins=/var/lib/grafana/plugins cfg:default.paths.provisioning=/etc/grafana/provisioning
Restart=always
LimitNOFILE=100000

[Install]
WantedBy=multi-user.target
