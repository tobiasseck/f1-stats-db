# Formula 1 Data Analysis Project

## Introduction

This repository contains a comprehensive Formula 1 (F1) database setup and analysis project. The aim is to provide an extensive dataset for exploring various aspects of Formula 1 racing, including circuits, drivers, constructors, race results, and more, using SQL queries.

## Setup Instructions

### Step 1: Data Acquisition
- Download the F1 data folder from One Drive:
[Download Link](https://datasmartpoint-my.sharepoint.com/:f:/p/tobias_seck-student/EnmhC0Ja6UpOpo2hTLYR6XIBa7SLzwQExASCZNdLDsiLsg?e=gO7Scs)
- Originally, I pulled the data from [Kaggle](https://www.kaggle.com/datasets/rohanrao/formula-1-world-championship-1950-2020). Before being able to use the data in the format provided in the download link, I had to clean the data.

### Step 2: Data Setup
Unpack and move the F1 folder to your desired location on your PC/Mac or network.

### Step 3: Path Configuration in MySQL Workbench
Use the Find & Replace function in MySQL Workbench to replace the file path in the SQL scripts with the location of your F1 folder.

### Step 4: Database Creation and Table Setup
Run the provided SQL scripts to create the F1 database, its tables, and import datasets.

### Step 5: Exploration
Start exploring the database with SQL queries to uncover insights about the F1 world.

## Database Structure

- Circuits: Information about race circuits.
- Drivers: Details of F1 drivers.
- Constructors: Data on F1 teams.
- Seasons: Season-wise data.
- Races: Detailed information on each race.
- Race Results: Results of individual races.
- Constructor Results: Team performances in races.
- Status: Status codes for race outcomes.
- Driver Standings: Seasonal performance of drivers.
- Constructor Standings: Seasonal performance of teams.
- Qualifying: Qualifying round details.
- Pitstops: Information about pitstops during races.
- Lap Times: Lap time data for drivers.

## Sample Queries

- [**Most Successful Drivers**](https://github.com/tobiasseck/f1-stats-db/blob/main/all-time-wins.sql): Retrieve a list of drivers with the most race wins in F1 history.
- [**World Champions by Year**](https://github.com/tobiasseck/f1-stats-db/blob/main/record-of-f1-champions.sql): List F1 World Champions for each year, along with their team and nationality.

## Reflections and Learnings

This project has been a deep dive into the world of Formula 1, offering insights into data structuring, database management, and SQL querying. Handling a dataset of this magnitude has been a rigorous exercise in data organization and query optimization. This type of approach to handling the motorsports series' statistics data would be typical for a platform providing insights into the sport.

## Future Directions

- **Data Expansion**: Continuously update and expand the dataset with new seasons and race data.
- **Advanced Analysis**: Looking to implement more complex queries and possibly integrate this data with analytical tools for deeper insights. At this time, I've only utilized MySQL to query the data in a structured format. Consequently, logical next steps would take this data to more advanced data analytics tools such as Python, R, or Tableau to create actionable insights and visualizations.

## Contact Information

- **Name**: Tobias Seck
- **LinkedIn**: [Tobias Seck](https://www.linkedin.com/in/tobiasseck/)
- **Email**: contact@tobiasseck.com

---

For more detailed information and insights, visit my professional portfolio: [Tobias Seck's Portfolio](https://tobiasseck.com).
