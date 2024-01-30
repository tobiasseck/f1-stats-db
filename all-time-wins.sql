-- Select all F1 drivers who scored at least one race win and sort them
-- to create a list showing the most successful drivers in terms of race
-- wins in Formula One Championship history.

select
	concat(d.driver_firstname, " ", d.driver_lastname) as Fahrer,
	d.driver_nationality as Nationalität,
    count(rr.rres_id) as Siege
		from f1.drivers d
		join f1.raceresults rr on rr.driver_id = d.driver_id
	where rr.rres_poition = 1
group by d.driver_id
order by 3 desc;
