# How Green is the Energy we use? 
🌎 Creating a dashboard for tracking global low-carbon energy consumption and its impact on CO2 emissions.

> #### Project Status: [Completed]


![Captura de Tela (9)](https://user-images.githubusercontent.com/122936255/215545006-45224a36-7173-4e34-978f-217180bcca6f.png)


## Project Description
The main goal of the project was to create a tool to track the growth and evolution of low-carbon energy (i.e. hydro, nuclear, wind, solar) throughout the world. Additionally, the aim was to explore the data further and test a few hypotheses regarding the use of clean energy sources and their relationship with overall CO2 emissions and other key economic indicators. 

To answer these questions and to develop insights for further validation, descriptive and diagnostic data analytics were imployed with SQL using Google BigQuery - [the queries and scripts can be found here](https://github.com/hafluz/energy_data/blob/main/energy_python.ipynb).

Afterward, the [dashboard above](https://public.tableau.com/views/GlobalEnergyConsumptionDashboard/HOWGREENISTHEENERGYWEUSE?:language=pt-BR&publish=yes&:display_count=n&:origin=viz_share_link) was built with Tableau using the most insightful KPIs and visualizations.

There was also an effort to integrate and sync the entire process in the cloud, beginning with the datasets being hosted on Google Cloud, querying with BigQuery, automating with Python to export dataframes to Google Drive, and finally data syncing with Tableau to build and share visualizations. 


### Links
* **Python Code:** [`energy_python.ipynb`](https://github.com/hafluz/energy_data/blob/main/energy_python.ipynb)   
* **SQL Queries:** [`energy_sql_scripts.sql`](https://github.com/hafluz/energy_data/blob/main/energy_sql_scripts.sql)    
* **Dashboard:** [`Tableau dashboard`](https://public.tableau.com/views/GlobalEnergyConsumptionDashboard/HOWGREENISTHEENERGYWEUSE?:language=pt-BR&publish=yes&:display_count=n&:origin=viz_share_link)  


### Methodology
* Data preparation and wrangling
* Data Cleaning
* Exploratory Data Analysis
* Setting KPIs
* Descriptive statistics   
* Data visualization

### Steps
1. Understanding the Global energy context and defining questions
2. Researching and collecting meaningful and updated datasets
3. Setting up the Database with Google Cloud
4. Data preparation and cleaning with SQL using BigQuery 
5. Exploratory data analysis with SQL using BigQuery 
6. Syncing and exporting SQL queries with Google Drive using Python
7. Importing datasets into Tableau through Google Drive integration
8. Analysing the and creating data visualizations with Tableau
9. Dashboard development with Tableau
10. Sharing of final insights

### Tools
* SQL
* BigQuery
* Python
* Pandas, Jupyter
* Tableau
* Google Cloud


### Sources
* [BP Statistical Review of World Energy 2022 (Energy data)](https://www.bp.com/en/global/corporate/energy-economics/statistical-review-of-world-energy.html)
* [World Bank Open Data (Economy data)](https://data.worldbank.org)


## Contact
Feel free to contact me with any questions or if you are interested in colaborating on other data analysis projects!

**Henrique Augsten**

* **Github: [github.com/hafluz](https://github.com/hafluz)**
* **LinkedIn: [linkedin.com/in/henrique-augsten](https://www.linkedin.com/in/henrique-augsten)**


