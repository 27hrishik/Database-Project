--Procedure 1--
delimiter $$
create procedure updateAvailability(
    in id int
)
begin
    declare today_date,end_date date;
    declare mon,tue,wed,thur,fri,sat,sun boolean;
    declare cap int;
    declare seat int default 1;
    select capacity,monday,tuesday,wednesday,thursday,friday,saturday,sunday 
    into cap,mon,tue,wed,thur,fri,sat,sun 
    from bus_detail 
    where bus_id = id;
    set today_date = current_date();
    set end_date = date_add(today_date,interval 30 day);
    while today_date <= end_date do
        case weekday(today_date)
            when 0 then 
                if mon = 1 then
                    call setSeats(id,today_date,cap);
                end if;
            when 1 then 
                if tue = 1 then
                    call setSeats(id,today_date,cap);
                end if;
            when 2 then 
                if wed = 1 then
                    call setSeats(id,today_date,cap);
                end if;
            when 3 then 
                if thur = 1 then
                    call setSeats(id,today_date,cap);
                end if;
            when 4 then 
                if fri = 1 then
                    call setSeats(id,today_date,cap);
                end if;
            when 5 then 
                if sat = 1 then
                    call setSeats(id,today_date,cap);
                end if;
            when 6 then 
                if sun = 1 then
                    call setSeats(id,today_date,cap);
                end if;
        end case;
        set today_date = date_add(today_date,interval 1 day);                                                 
    end while;
end $$
delimiter ;

--Procedure 2--
delimiter //
create procedure setSeats(
    in id int,
    in dat date,
    in cap int 
)
begin
    declare seat int default 1;
    insert ignore into seat_availability
    values (id,dat,cap);
    while seat <= cap do
        insert ignore into seat(bus_id,date_of_journey,seat_no) values (id,dat,seat);
        set seat = seat + 1;
    end while ;
end //
delimiter ;        

--Trigger 1--
delimiter $$
create trigger updateSeat
after insert
on seat_booked for each row
begin
    declare b_id int;
    declare d date;
    select bus_id,date_of_journey into b_id,d
    from ticket
    where ticket_id = new.ticket_id;
    update seat 
    set check_availability = new.ticket_id
    where bus_id = b_id and date_of_journey = d and seat_no = new.seat_no and check_availability is null;
    update seat_availability
    set seats_available = seats_available - 1
    where bus_id = b_id and date_of_journey = d;  
end $$
delimiter ;