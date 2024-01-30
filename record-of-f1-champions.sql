select
  Jahr,
  Fahrer,
  Nationalität,
  Team,
  Siege,
  Rennen
    from
    	(select
        year(f1.races.race_date) as Jahr,
        concat(f1.drivers.driver_firstname, " ", f1.drivers.driver_lastname) as Fahrer,
        f1.driverstandings.dvrst_position as Position,
        f1.races.race_round as Rennen,
        f1.drivers.driver_nationality as Nationalität,
        f1.constructors.con_name as Team, f1.driverstandings.dvrst_wins as Siege,
    	  row_number() over (partition by year(f1.races.race_date) order by f1.races.race_round desc, f1.driverstandings.dvrst_points desc) as Endstand
      		from f1.drivers
      		join f1.raceresults on f1.raceresults.driver_id = f1.drivers.driver_id
      		join f1.races on f1.races.race_id = f1.raceresults.race_id
      		join f1.driverstandings on f1.driverstandings.race_id = f1.races.race_id and f1.driverstandings.driver_id = f1.drivers.driver_id
              #Die Verknüpfung über alle verfügbaren Fremdschlüssel führt dazu, dass nur die Driver Informationen ausgelesen werden,
              #die zu Driverstandings gehören und nicht zu den Raceresults
      		join f1.constructors on f1.constructors.con_id = f1.raceresults.con_id
    		where f1.driverstandings.dvrst_position = 1
            #Um in der temporären Tabelle nur Welteisterschaftsführende gelistet zu bekommen!  
    		) as t
where Endstand = 1
order by Jahr desc;
