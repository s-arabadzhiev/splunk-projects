# 🌦️ Splunk Weather Analytics: Mincho Praznikov Add-on

## 📌 Overview

`TA-mincho-praznikov` is a custom **Splunk Add-on** designed to ingest, parse, and analyze real-time weather data using the **OpenWeatherMap API**.

The project demonstrates advanced **Splunk administration and data engineering practices**, including modular inputs, custom field extractions, dedicated indexing strategies, and automated **“Lab as Code”** deployment.

The Add-on was built with **Splunk Add-on Builder** and integrates **Python, REST API ingestion, and SPL-based analytics**.

---

# 🚀 Key Features

### ⚙️ Automated Deployment

A master script (`setup_lab.sh`) provides **one-command deployment** of the entire lab environment.

The script automatically:

- Detects an existing Splunk installation
- Installs Splunk Enterprise if missing
- Deploys the Add-on configuration
- Configures required indexes

This allows the entire environment to be deployed in minutes.

---

### 🔌 Custom Modular Inputs

The Add-on implements a **custom modular input** that connects to the **OpenWeatherMap API** and periodically collects weather data.

Example metrics ingested:

- Temperature
- Humidity
- Atmospheric pressure
- Wind speed
- Wind direction
- Geographic coordinates

Example monitored location:

```
Kazanlak, Bulgaria
```

---

### 🔎 Advanced Field Extractions

Custom **Regular Expressions (RegEx)** in `props.conf` parse raw JSON events and extract structured fields.

Extracted fields include:

**Temperature**

- `temp`
- `feels_like`
- `temp_min`
- `temp_max`

**Wind**

- `wind_speed`
- `wind_deg`
- `wind_gust`

**Coordinates**

- `lon`
- `lat`

These fields allow efficient SPL searches and dashboard visualizations.

---

### 🗂️ Optimized Storage

Dedicated indexes are created to separate different weather data types.

| Index | Purpose |
|-----|-----|
| `weather_data_idx` | Real-time weather metrics |
| `forecast` | Weather forecast data |

This separation allows:

- Different retention policies
- Improved search performance
- Clear data organization

---

### 🔐 Custom REST Endpoints

The Add-on includes **custom REST handlers** and **Splunk Web endpoints** to manage configuration securely through the UI.

Administrators can:

- Configure API keys
- Enable/disable inputs
- Manage data collection settings

without editing configuration files manually.

---

# 📂 Repository Structure

```
splunk-projects/
├── TA-mincho-praznikov/
│   ├── configs/                       # Exported Splunk configurations
│   │   ├── apps/
│   │   │   └── TA-mincho-praznikov/   # App logic, local configs, and metadata
│   │   └── system/
│   │       └── local/                 # System-wide settings
│   ├── scripts/                       # Installation utility scripts
│   │   ├── splunk_install.sh          # Automated Splunk Enterprise installer
│   │   
│   ├── setup_lab.sh                   # Master deployment script
│   └── README.md                      # Project documentation
└── .gitignore                         # Security filters for credentials and logs
```

---

# 🛠️ Installation & Deployment

## Prerequisites

Before deploying the project ensure the following requirements are met:

- Linux environment (**Ubuntu** or **CentOS** recommended)
- `sudo` privileges
- Valid **OpenWeatherMap API key**

---

# ⚡ Automated Setup

Clone the repository:

```bash
git clone <your-repository-url>
cd splunk-projects/TA-mincho-praznikov
```

Make deployment scripts executable:

```bash
sudo chmod +x setup_lab.sh scripts/*.sh
```

Run the master setup script:

```bash
sudo ./setup_lab.sh
```

### What the script does

1. Detects if Splunk Enterprise is installed
2. Installs Splunk if necessary
3. Deploys the Add-on configuration
4. Creates required indexes
5. Configures the environment

If Splunk is not detected, the script automatically runs:

```
scripts/splunk_install.sh
```

---

# ⚙️ Post-Deployment Configuration

For security reasons, **credentials are not stored in the repository**.

The following files are excluded via `.gitignore`:

- `passwords.conf`
- `splunk.secret`
- API credentials

---

## Enable Data Collection

After deployment:

1. Log in to **Splunk Web**
2. Open the **Mincho Praznikov App**
3. Navigate to:

```
Configuration → Inputs
```

4. Edit the input:

```
openweather
```

5. Add your **OpenWeatherMap API Key**
6. Enable the input

Once enabled, Splunk will begin ingesting **real-time weather data**.

---

# 🔍 Technical Details

## Field Extraction Logic

The Add-on performs **search-time JSON parsing** using RegEx in `props.conf`.

Example extracted fields:

| Field | Description |
|-----|-----|
| `temp` | Current temperature |
| `feels_like` | Perceived temperature |
| `humidity` | Humidity percentage |
| `wind_speed` | Wind velocity |
| `wind_deg` | Wind direction |
| `lon` | Longitude |
| `lat` | Latitude |

---

## Indexing Strategy

The Add-on provisions **dedicated storage buckets** defined in `indexes.conf`.

Benefits:

- Improved query performance
- Logical separation of datasets
- Custom retention policies

Example configuration:

```
weather_data_idx
forecast
```

---

# 🧰 Technology Stack

- **Splunk Enterprise**
- **Splunk Add-on Builder**
- **Python 3**
- **Bash**
- **SPL (Search Processing Language)**
- **REST API**
- **JSON**

---

# 👨‍💻 Author

**sarabadzhiev**

---

# 📄 Version

```
1.0.0
```

---

# ⭐ Purpose of the Project

This project was built as part of a **Splunk engineering lab** to demonstrate:

- Splunk Add-on development
- Modular input integration
- Automated infrastructure deployment
- Advanced field extraction techniques
- Practical REST API ingestion

It can be used as a **reference implementation for building custom Splunk integrations**.