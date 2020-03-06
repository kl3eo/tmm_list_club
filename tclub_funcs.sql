CREATE OR REPLACE FUNCTION public.aa(text)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from doubles where participant1 ~ cc1($1) and winner is not null and score !~ 'w/o'$function$

CREATE OR REPLACE FUNCTION public.cc1(text)
 RETURNS text
 LANGUAGE sql
AS $function$select ('^'|| $1 || '/')$function$

CREATE OR REPLACE FUNCTION public.cc2(text)
 RETURNS text
 LANGUAGE sql
AS $function$select ('/'|| $1 || '$')$function$

CREATE OR REPLACE FUNCTION public.get_next_rnd_name(text)
 RETURNS text
 LANGUAGE sql
AS $function$select case when $1 = 'r128' then 'r064' else
(case when $1 = 'r064' then 'r032' else
(case when $1 = 'r032' then 'r016' else
(case when $1 = 'r016' then 'r008' else
(case when $1 = 'r008' then 'r004' else
(case when $1 = 'r004'  then 'r002' end) end) end) end) end) end$function$

CREATE OR REPLACE FUNCTION public.get_prev_rnd_name(text)
 RETURNS text
 LANGUAGE sql
AS $function$select case when $1 = 'r002' then 'r004' else
(case when $1 = 'r004' then 'r008' else
(case when $1 = 'r008' then 'r016' else
(case when $1 = 'r016' then 'r032' else
(case when $1 = 'r032' then 'r064' else
(case when $1 = 'r064'  then 'r128' end) end) end) end) end) end$function$

CREATE OR REPLACE FUNCTION public.getwinner1(integer, text, integer)
 RETURNS text
 LANGUAGE sql
AS $function$select participant1 from matches where tournir_id = $1 and round = $2 and match_num_in_round = $3
and winner='t'$function$

CREATE OR REPLACE FUNCTION public.getwinner1(integer, text, integer, integer)
 RETURNS text
 LANGUAGE sql
AS $function$select participant1 from matches where tournir_id = $1 and round = $2 and match_num_in_round = $3
and winner='t' and sport = $4$function$

CREATE OR REPLACE FUNCTION public.getwinner1_year(integer, text, integer)
 RETURNS text
 LANGUAGE sql
AS $function$select participant1 from matches where tournir_id = $1 and round = $2 and match_num_in_round = $3
and winner='t' and (current_date-match_date) <= 730$function$

CREATE OR REPLACE FUNCTION public.getwinner1_year(integer, text, integer, integer)
 RETURNS text
 LANGUAGE sql
AS $function$select participant1 from matches where tournir_id = $1 and round = $2 and match_num_in_round = $3
and winner='t' and (current_date-match_date) <= 730 and sport = $4$function$

CREATE OR REPLACE FUNCTION public.getwinner2(integer, text, integer)
 RETURNS text
 LANGUAGE sql
AS $function$select participant2 from matches where tournir_id = $1 and round = $2 and match_num_in_round = $3
and winner='f'$function$

CREATE OR REPLACE FUNCTION public.getwinner2(integer, text, integer, integer)
 RETURNS text
 LANGUAGE sql
AS $function$select participant2 from matches where tournir_id = $1 and round = $2 and match_num_in_round = $3
and winner='f' and sport = $4$function$

CREATE OR REPLACE FUNCTION public.getwinner2_year(integer, text, integer)
 RETURNS text
 LANGUAGE sql
AS $function$select participant2 from matches where tournir_id = $1 and round = $2 and match_num_in_round = $3
and winner='f' and (current_date-match_date) <= 730$function$

CREATE OR REPLACE FUNCTION public.getwinner2_year(integer, text, integer, integer)
 RETURNS text
 LANGUAGE sql
AS $function$select participant2 from matches where tournir_id = $1 and round = $2 and match_num_in_round = $3
and winner='f' and (current_date-match_date) <= 730 and sport = $4$function$

CREATE OR REPLACE FUNCTION public.is_orphaned_message(text)
 RETURNS boolean
 LANGUAGE sql
AS $function$select case when search_record($1) = 0 and $1 != 'reply_to_num' then true 
else false end$function$

CREATE OR REPLACE FUNCTION public.maxdate(text)
 RETURNS date
 LANGUAGE sql
AS $function$select max(match_date) from matches where participant1 = $1 or participant2 = $1$function$

CREATE OR REPLACE FUNCTION public.mindate(text)
 RETURNS date
 LANGUAGE sql
AS $function$select min(match_date) from matches where participant1 = $1 or participant2 = $1$function$

CREATE OR REPLACE FUNCTION public.nonull(integer)
 RETURNS integer
 LANGUAGE sql
AS $function$select case when $1 is null then 0 
else $1 end$function$

CREATE OR REPLACE FUNCTION public.num_ccdaily_to_date(text)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(distinct ccdate) from ccdaily where player = $1 and current_date-ccdate <= 30$function$

CREATE OR REPLACE FUNCTION public.num_of_doubles_victories(text, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from doubles where ((((participant1 ~ ('^' || $1 || '/') or participant1 ~ ('/' || $1 || '$')) 
    and winner='t' and sport = $2) or
((participant2 ~ ('^' || $1 || '/') or participant2 ~ ('/' || $1 || '$')) and winner='f' and sport = $2)) and score !~ 'w/o')$function$

CREATE OR REPLACE FUNCTION public.num_of_played_doubles(text, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from doubles 
    where ((participant1 ~ ('^' || $1 || '/') or participant2 ~ ('^' || $1 || '/') 
or participant1 ~ ('/' || $1 || '$') or participant2 ~ ('/' || $1 || '$')) 
    and winner is not null and score !~ 'w/o' and sport = $2)$function$

CREATE OR REPLACE FUNCTION public.num_of_played_good_doubles(text)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from doubles 
    where ((participant1 ~ ('^' || $1 || '/') 
    or participant2 ~ ('^' || $1 || '/') 
or participant1 ~ ('/' || $1 || '$') 
or participant2 ~ ('/' || $1 || '$')) 
    and winner is not null and score !~ 'w/o')
and not (points_winner = 0 and points_loser = 0)$function$

CREATE OR REPLACE FUNCTION public.num_of_played_good_doubles(text, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from doubles 
    where ((participant1 ~ ('^' || $1 || '/') 
    or participant2 ~ ('^' || $1 || '/') 
or participant1 ~ ('/' || $1 || '$') 
or participant2 ~ ('/' || $1 || '$')) 
    and winner is not null and score !~ 'w/o' and sport = $2)
and not (points_winner = 0 and points_loser = 0)$function$

CREATE OR REPLACE FUNCTION public.num_of_played_good_doubles_period(text, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from doubles 
    where ((participant1 ~ ('^' || $1 || '/') 
    or participant2 ~ ('^' || $1 || '/') 
or participant1 ~ ('/' || $1 || '$') 
or participant2 ~ ('/' || $1 || '$')) 
    and winner is not null and score !~ 'w/o' and (current_date-match_date) <= $2)
and not (points_winner = 0 and points_loser = 0)$function$

CREATE OR REPLACE FUNCTION public.num_of_played_good_doubles_period(text, integer, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from doubles 
    where ((participant1 ~ ('^' || $1 || '/') 
    or participant2 ~ ('^' || $1 || '/') 
or participant1 ~ ('/' || $1 || '$') 
or participant2 ~ ('/' || $1 || '$')) 
    and winner is not null and score !~ 'w/o' and (current_date-match_date) <= $2 and sport = $3)
and not (points_winner = 0 and points_loser = 0)$function$

CREATE OR REPLACE FUNCTION public.num_of_played_good_doubles_year(text)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from doubles 
    where ((participant1 ~ ('^' || $1 || '/') 
    or participant2 ~ ('^' || $1 || '/') 
or participant1 ~ ('/' || $1 || '$') 
or participant2 ~ ('/' || $1 || '$')) 
    and winner is not null and score !~ 'w/o' and (current_date-match_date) <= 730)
and not (points_winner = 0 and points_loser = 0)$function$

CREATE OR REPLACE FUNCTION public.num_of_played_good_doubles_year(text, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from doubles 
    where ((participant1 ~ ('^' || $1 || '/') 
    or participant2 ~ ('^' || $1 || '/') 
or participant1 ~ ('/' || $1 || '$') 
or participant2 ~ ('/' || $1 || '$')) 
    and winner is not null and score !~ 'w/o' and sport = $2 and (current_date-match_date) <= 730)
and not (points_winner = 0 and points_loser = 0)$function$

CREATE OR REPLACE FUNCTION public.num_of_played_good_matches(text)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from matches where (((participant1 = $1) or
(participant2 = $1)) and winner is not null and score !~ 'w/o')
and not (points_winner = 0 and points_loser = 0)$function$

CREATE OR REPLACE FUNCTION public.num_of_played_good_matches(text, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from matches where (((participant1 = $1 and sport = $2) or
(participant2 = $1 and sport = $2)) and winner is not null and score !~ 'w/o')
and not (points_winner = 0 and points_loser = 0)$function$

CREATE OR REPLACE FUNCTION public.num_of_played_good_matches_period(text, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from matches where (((participant1 = $1) or
(participant2 = $1)) and winner is not null and score !~ 'w/o' and (current_date-match_date) <= $2) 
and not (points_winner = 0 and points_loser = 0)$function$

CREATE OR REPLACE FUNCTION public.num_of_played_good_matches_period(text, integer, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from matches where (((participant1 = $1) or
(participant2 = $1)) and winner is not null and score !~ 'w/o' and sport = $3 and (current_date-match_date) <= $2) 
and not (points_winner = 0 and points_loser = 0)$function$

CREATE OR REPLACE FUNCTION public.num_of_played_good_matches_year(text)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from matches where (((participant1 = $1) or
(participant2 = $1)) and winner is not null and score !~ 'w/o' and (current_date-match_date) <= 730) 
and not (points_winner = 0 and points_loser = 0)$function$

CREATE OR REPLACE FUNCTION public.num_of_played_good_matches_year(text, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from matches where (((participant1 = $1) or
(participant2 = $1)) and winner is not null and score !~ 'w/o' and sport = $2 and (current_date-match_date) <= 730) 
and not (points_winner = 0 and points_loser = 0)$function$

CREATE OR REPLACE FUNCTION public.num_of_played_matches(text)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from matches where (((participant1 = $1) or
(participant2 = $1)) and winner is not null and score !~ 'w/o')$function$

CREATE OR REPLACE FUNCTION public.num_of_played_matches(text, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from matches where (((participant1 = $1 and sport = $2) or
(participant2 = $1 and sport = $2)) and winner is not null and score !~ 'w/o')$function$

CREATE OR REPLACE FUNCTION public.num_of_played_matches_current_month(text)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from matches where (((participant1 = $1) or
(participant2 = $1)) and winner is not null and score !~ 'w/o') and ( extract(month from current_date)-extract(month from match_date)  = 0 and (current_date-match_date <= 31));$function$

CREATE OR REPLACE FUNCTION public.num_of_played_matches_current_month(text, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from matches where (((participant1 = $1 and sport = $2) or
(participant2 = $1 and sport = $2)) and winner is not null and score !~ 'w/o') and ( extract(month from current_date)-extract(month from match_date)  = 0 and (current_date-match_date <= 31));$function$

CREATE OR REPLACE FUNCTION public.num_of_played_matches_period(text, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from matches where (((participant1 = $1) or
(participant2 = $1)) and winner is not null and score !~ 'w/o' and (current_date-match_date) <= $2)$function$

CREATE OR REPLACE FUNCTION public.num_of_played_matches_period(text, integer, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from matches where (((participant1 = $1 and sport = $3) or
(participant2 = $1 and sport = $3)) and winner is not null and score !~ 'w/o' and (current_date-match_date) <= $2)$function$

CREATE OR REPLACE FUNCTION public.num_of_played_matches_year(text)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from matches where (((participant1 = $1) or
(participant2 = $1)) and winner is not null and score !~ 'w/o' and (current_date-match_date) <= 730)$function$

CREATE OR REPLACE FUNCTION public.num_of_played_matches_year(text, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from matches where (((participant1 = $1 and sport = $2) or
(participant2 = $1 and sport = $2)) and winner is not null and score !~ 'w/o' and (current_date-match_date) <= 730)$function$

CREATE OR REPLACE FUNCTION public.num_of_played_this_tournir_matches(text, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from matches where (((participant1 = $1) or (participant2 = $1)) and tournir_id = $2 and winner is not null and score !~ 'w/o')$function$

CREATE OR REPLACE FUNCTION public.num_of_played_this_tournir_matches(text, integer, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from matches where (((participant1 = $1 and sport = $3) or (participant2 = $1 and sport = $3)) and tournir_id = $2 and winner is not null and score !~ 'w/o')$function$

CREATE OR REPLACE FUNCTION public.num_of_unique_played_matches_current_month(text)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from current_month_matches where participant1 = $1$function$

CREATE OR REPLACE FUNCTION public.num_of_unique_played_matches_current_month(text, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from current_month_matches where participant1 = $1 and sport = $2$function$

CREATE OR REPLACE FUNCTION public.num_of_unique_played_matches_current_month_three(text)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from current_month_matches_three where participant1 = $1$function$

CREATE OR REPLACE FUNCTION public.num_of_unique_played_matches_current_month_three(text, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from current_month_matches_three where participant1 = $1 and sport = $2$function$

CREATE OR REPLACE FUNCTION public.num_of_unique_played_matches_in_month(text, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from month_matches where participant1 = $1 and month = $2$function$

CREATE OR REPLACE FUNCTION public.num_of_unique_played_matches_in_month(text, integer, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from month_matches where participant1 = $1 and month = $2 and sport = $3$function$

CREATE OR REPLACE FUNCTION public.num_of_unique_played_matches_in_month_three(text, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from month_matches_three where participant1 = $1 and month = $2$function$

CREATE OR REPLACE FUNCTION public.num_of_unique_played_matches_in_month_three(text, integer, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from month_matches_three where participant1 = $1 and month = $2 and sport = $3$function$

CREATE OR REPLACE FUNCTION public.num_of_unique_played_matches_last_month(text)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from last_month_matches where participant1 = $1$function$

CREATE OR REPLACE FUNCTION public.num_of_unique_played_matches_last_month(text, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from last_month_matches where participant1 = $1 and sport = $2$function$

CREATE OR REPLACE FUNCTION public.num_of_unique_victories_current_month(text)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from current_month_matches where participant1 = $1 and winner='t'$function$

CREATE OR REPLACE FUNCTION public.num_of_unique_victories_current_month(text, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from current_month_matches where participant1 = $1 and winner='t' and sport = $2$function$

CREATE OR REPLACE FUNCTION public.num_of_unique_victories_current_month_three(text)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from current_month_matches_three where participant1 = $1 and winner='t'$function$

CREATE OR REPLACE FUNCTION public.num_of_unique_victories_current_month_three(text, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from current_month_matches_three where participant1 = $1 and winner='t' and sport = $2$function$

CREATE OR REPLACE FUNCTION public.num_of_unique_victories_in_month(text, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from month_matches where participant1 = $1 and month = $2 and winner='t'$function$

CREATE OR REPLACE FUNCTION public.num_of_unique_victories_in_month(text, integer, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from month_matches where participant1 = $1 and month = $2 and winner='t' and sport = $3$function$

CREATE OR REPLACE FUNCTION public.num_of_unique_victories_in_month_three(text, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from month_matches_three where participant1 = $1 and month = $2 and winner='t'$function$

CREATE OR REPLACE FUNCTION public.num_of_unique_victories_in_month_three(text, integer, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from month_matches_three where participant1 = $1 and month = $2 and winner='t' and sport = $3$function$

CREATE OR REPLACE FUNCTION public.num_of_unique_victories_last_month(text)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from last_month_matches where participant1 = $1 and winner='t'$function$

CREATE OR REPLACE FUNCTION public.num_of_unique_victories_last_month(text, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from last_month_matches where participant1 = $1 and winner='t' and sport = $2$function$

CREATE OR REPLACE FUNCTION public.num_of_victories(text)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from matches where (((participant1 = $1 and winner='t') or
(participant2 = $1 and winner='f')) and score !~ 'w/o')$function$

CREATE OR REPLACE FUNCTION public.num_of_victories(text, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from matches where (((participant1 = $1 and winner='t' and sport = $2) or
(participant2 = $1 and winner='f' and sport = $2)) and score !~ 'w/o')$function$

CREATE OR REPLACE FUNCTION public.num_of_victories_current_month(text)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from matches where (((participant1 = $1 and winner='t') or
(participant2 = $1 and winner='f')) and score !~ 'w/o') and ( extract(month from current_date)-extract(month from match_date)  = 0 and (current_date-match_date <= 31))$function$

CREATE OR REPLACE FUNCTION public.num_of_victories_current_month(text, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from matches where (((participant1 = $1 and winner='t' and sport = $2) or
(participant2 = $1 and winner='f' and sport = $2)) and score !~ 'w/o') and ( extract(month from current_date)-extract(month from match_date)  = 0 and (current_date-match_date <= 31))$function$

CREATE OR REPLACE FUNCTION public.num_of_victories_period(text, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from matches where (((participant1 = $1 and winner='t') or
(participant2 = $1 and winner='f')) and score !~ 'w/o' and (current_date-match_date) <= $2)$function$

CREATE OR REPLACE FUNCTION public.num_of_victories_period(text, integer, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from matches where (((participant1 = $1 and winner='t' and sport = $3) or
(participant2 = $1 and winner='f' and sport = $3)) and score !~ 'w/o' and (current_date-match_date) <= $2)$function$

CREATE OR REPLACE FUNCTION public.num_of_victories_year(text)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from matches where (((participant1 = $1 and winner='t') or
(participant2 = $1 and winner='f')) and score !~ 'w/o' and (current_date-match_date) <= 730)$function$

CREATE OR REPLACE FUNCTION public.num_of_victories_year(text, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from matches where (((participant1 = $1 and winner='t' and sport = $2) or
(participant2 = $1 and winner='f' and sport = $2)) and score !~ 'w/o' and (current_date-match_date) <= 730)$function$

CREATE OR REPLACE FUNCTION public.plpgsql_call_handler()
 RETURNS language_handler
 LANGUAGE c
AS '$libdir/plpgsql', $function$plpgsql_call_handler$function$

CREATE OR REPLACE FUNCTION public.points_l(text)
 RETURNS bigint
 LANGUAGE sql
AS $function$select sum(points_loser) from matches where ((participant1 = $1 and winner='f') or
(participant2 = $1 and winner='t'))$function$

CREATE OR REPLACE FUNCTION public.points_l(text, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select sum(points_loser) from matches where ((participant1 = $1 and winner='f' and sport = $2) or
(participant2 = $1 and winner='t' and sport = $2))$function$

CREATE OR REPLACE FUNCTION public.points_l_period(text, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select sum(points_loser) from matches where ((participant1 = $1 and winner='f') or
(participant2 = $1 and winner='t')) and (current_date-match_date) <= $2$function$

CREATE OR REPLACE FUNCTION public.points_l_period(text, integer, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select sum(points_loser) from matches where ((participant1 = $1 and winner='f' and sport = $3) or
(participant2 = $1 and winner='t' and sport = $3)) and (current_date-match_date) <= $2$function$

CREATE OR REPLACE FUNCTION public.points_l_year(text)
 RETURNS bigint
 LANGUAGE sql
AS $function$select sum(points_loser) from matches where ((participant1 = $1 and winner='f') or
(participant2 = $1 and winner='t')) and (current_date-match_date) <= 730$function$

CREATE OR REPLACE FUNCTION public.points_l_year(text, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select sum(points_loser) from matches where ((participant1 = $1 and winner='f' and sport = $2) or
(participant2 = $1 and winner='t' and sport = $2)) and (current_date-match_date) <= 730$function$

CREATE OR REPLACE FUNCTION public.points_w(text)
 RETURNS bigint
 LANGUAGE sql
AS $function$select sum(points_winner) from matches where ((participant1 = $1 and winner='t') or
(participant2 = $1 and winner='f'))$function$

CREATE OR REPLACE FUNCTION public.points_w(text, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select sum(points_winner) from matches where ((participant1 = $1 and winner='t' and sport = $2) or
(participant2 = $1 and winner='f' and sport = $2))$function$

CREATE OR REPLACE FUNCTION public.points_w_period(text, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select sum(points_winner) from matches where ((participant1 = $1 and winner='t') or
(participant2 = $1 and winner='f')) and (current_date-match_date) <= $2$function$

CREATE OR REPLACE FUNCTION public.points_w_period(text, integer, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select sum(points_winner) from matches where ((participant1 = $1 and winner='t' and sport = $3) or
(participant2 = $1 and winner='f' and sport = $3)) and (current_date-match_date) <= $2$function$

CREATE OR REPLACE FUNCTION public.points_w_year(text)
 RETURNS bigint
 LANGUAGE sql
AS $function$select sum(points_winner) from matches where ((participant1 = $1 and winner='t') or
(participant2 = $1 and winner='f')) and (current_date-match_date) <= 730$function$

CREATE OR REPLACE FUNCTION public.points_w_year(text, integer)
 RETURNS bigint
 LANGUAGE sql
AS $function$select sum(points_winner) from matches where ((participant1 = $1 and winner='t' and sport = $2) or
(participant2 = $1 and winner='f' and sport = $2)) and (current_date-match_date) <= 730$function$

CREATE OR REPLACE FUNCTION public.rating(text)
 RETURNS integer
 LANGUAGE sql
AS $function$select (nonull(points_w($1)::int) + nonull(points_l($1)::int))$function$

CREATE OR REPLACE FUNCTION public.rating(text, integer)
 RETURNS integer
 LANGUAGE sql
AS $function$select (nonull(points_w($1,$2)::int) + nonull(points_l($1,$2)::int))$function$

CREATE OR REPLACE FUNCTION public.rating_period(text, integer)
 RETURNS integer
 LANGUAGE sql
AS $function$select (nonull(points_w_period($1,$2)::int) + nonull(points_l_period($1,$2)::int))$function$

CREATE OR REPLACE FUNCTION public.rating_period(text, integer, integer)
 RETURNS integer
 LANGUAGE sql
AS $function$select (nonull(points_w_period($1,$2,$3)::int) + nonull(points_l_period($1,$2,$3)::int))$function$

CREATE OR REPLACE FUNCTION public.rating_year(text)
 RETURNS integer
 LANGUAGE sql
AS $function$select (nonull(points_w_year($1)::int) + nonull(points_l_year($1)::int))$function$

CREATE OR REPLACE FUNCTION public.rating_year(text, integer)
 RETURNS integer
 LANGUAGE sql
AS $function$select (nonull(points_w_year($1,$2)::int) + nonull(points_l_year($1,$2)::int))$function$

CREATE OR REPLACE FUNCTION public.search_record(text)
 RETURNS bigint
 LANGUAGE sql
AS $function$select count(oid) from forum where cast(oid as text) = $1$function$

CREATE OR REPLACE FUNCTION public.singles_rating(text, integer, integer)
 RETURNS double precision
 LANGUAGE sql
AS $function$select case when (num_of_played_good_matches($1) >= $2 or ( (num_of_played_good_matches($1) >= ($2 - num_of_played_good_doubles($1))) and
num_of_played_good_matches($1) >= $3 )) then (rating($1)::float / num_of_played_good_matches($1)::float) else 0.0 end$function$

CREATE OR REPLACE FUNCTION public.singles_rating(text, integer, integer, integer)
 RETURNS double precision
 LANGUAGE sql
AS $function$select case when (num_of_played_good_matches($1,$4) >= $2 or ( (num_of_played_good_matches($1,$4) >= ($2 - num_of_played_good_doubles($1,$4))) and
num_of_played_good_matches($1,$4) >= $3 )) then (rating($1,$4)::float / num_of_played_good_matches($1,$4)::float) else 0.0 end$function$

CREATE OR REPLACE FUNCTION public.singles_rating_year(text, integer, integer)
 RETURNS double precision
 LANGUAGE sql
AS $function$select case when (num_of_played_good_matches_year($1) >= $2 or ( (num_of_played_good_matches_year($1) >= ($2 -
num_of_played_good_doubles_year($1))) and
num_of_played_good_matches_year($1) >= $3 )) then (rating_year($1)::float / num_of_played_good_matches_year($1)::float) else 0.0 end$function$

CREATE OR REPLACE FUNCTION public.singles_rating_year(text, integer, integer, integer)
 RETURNS double precision
 LANGUAGE sql
AS $function$select case when (num_of_played_good_matches_year($1,$4) >= $2 or ( (num_of_played_good_matches_year($1,$4) >= ($2 -
num_of_played_good_doubles_year($1,$4))) and
num_of_played_good_matches_year($1,$4) >= $3 )) then (rating_year($1,$4)::float / num_of_played_good_matches_year($1,$4)::float) else 0.0 end$function$

CREATE OR REPLACE FUNCTION public.winner(integer, text, integer)
 RETURNS text
 LANGUAGE sql
AS $function$select case when getwinner1($1,$2,$3) is null then getwinner2($1,$2,$3)
else getwinner1($1,$2,$3) end$function$

CREATE OR REPLACE FUNCTION public.winner_year(integer, text, integer)
 RETURNS text
 LANGUAGE sql
AS $function$select case when getwinner1_year($1,$2,$3) is null then getwinner2_year($1,$2,$3)
else getwinner1($1,$2,$3) end$function$

CREATE OR REPLACE FUNCTION public._i_v1_dna(text, text, integer, integer)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
DECLARE 
r integer := 0;
resultCount integer := 0;
BEGIN

FOR r IN EXECUTE format('SELECT distinct %s FROM %s where %s > %s and %s < %s order by %s',$2,$1,$2,$3,$2,$4,$2)
    LOOP
EXECUTE format('create table v1_dna_%s (tab text, rev int, key bigint)', r);
resultCount = resultCount + 1;
    END LOOP;
   
return resultCount;
END;$function$

CREATE OR REPLACE FUNCTION public._w_v1_dna(text, text, integer)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
DECLARE 

    resultCount integer := 0;

BEGIN
EXECUTE format('truncate tmp');
EXECUTE format('insert into tmp select * from %s where %s = %s',$1,$2,$3);
EXECUTE format('insert into v1_dna_%s (tab, rev, key) select ''%s'',1,row_to_csv_rocks(%s,tmp) from tmp',$3,$1,$3);
EXECUTE format('select rocks_close()');

    return resultCount;

END;$function$

CREATE OR REPLACE FUNCTION public._d_rocksdb(integer, integer)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
DECLARE 

r int;
BEGIN

FOR r IN
EXECUTE format('SELECT split_part(table_name,''_'',3)::int FROM information_schema.tables WHERE table_name ~ ''v1_dna_'' and split_part(table_name,''_'',3)::int > %s and split_part(table_name,''_'',3)::int < %s order by split_part(table_name,''_'',3)::
int',$1,$2)
    LOOP
EXECUTE format('select rocks_destroy(%s)',  r);
    END LOOP;
RETURN 0;

END;$function$

CREATE OR REPLACE FUNCTION public._i_v1_dna(integer, integer, integer)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
DECLARE 

r integer := 0;
resultCount integer := 0;

BEGIN

FOR r IN

EXECUTE format('SELECT split_part(table_name,''_'',3)::int FROM information_schema.tables WHERE table_name ~ ''v1_dna_'' and split_part(table_name,''_'',3)::int > %s and split_part(table_name,''_'',3)::int < %s order by split_part(table_name,''_'',3)::
int',$1,$2)
    LOOP
EXECUTE format('drop table if exists v1_dna_%s', r);
if $3 = 1 then 
EXECUTE format('create table v1_dna_%s (tab text, rev int, key bigint)', r);
end if;
resultCount = resultCount + 1;
    END LOOP;
   
    return resultCount;

END;$function$

CREATE OR REPLACE FUNCTION public._d_c0(text, integer, integer)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
DECLARE 

r int;
BEGIN

FOR r IN
EXECUTE format('SELECT split_part(table_name,''_'',3)::int FROM information_schema.tables WHERE table_name ~ ''v1_dna_'' and split_part(table_name,''_'',3)::int > %s and split_part(table_name,''_'',3)::int < %s order by split_part(table_name,''_'',3)::
int',$2,$3)
    LOOP
EXECUTE format('drop table if exists %s_c0_%s', $1, r);
    END LOOP;
RETURN 0;

END;$function$

CREATE OR REPLACE FUNCTION public._wc_v1_dna(text, text, integer, integer)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
DECLARE 
resultCount integer := 0;
r int := $3+1;
BEGIN

EXECUTE format('create index if not exists %s_idx on %s (%s)',$1,$1,$2);
EXECUTE format('CREATE TEMP TABLE tmp on commit drop as select * from %s where %s = %s',$1,$2,r);

FOR r IN
EXECUTE format('SELECT distinct %s FROM %s where %s > %s and %s < %s order by %s',$2,$1,$2,$3,$2,$4,$2)
    LOOP
RAISE NOTICE 'Executing _w_v1_dna(''%'',''%'',%):', $1, $2, r;
EXECUTE format('select _w_v1_dna(''%s'',''%s'',%s)',$1, $2, r) into resultCount;

    END LOOP;
RETURN resultCount;

END;$function$

CREATE OR REPLACE FUNCTION public._atomic_c0(text, integer, bigint)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$

BEGIN

if ($1 = 'challenges' or $1 = 'matches' or $1 = 'doubles') then

else 
RETURN -1;
end if;

drop table if exists tmp;

if $1 = 'challenges' then

EXECUTE format('create temp table tmp on commit drop as select %s, d.*  
from v1_dna_%s, rocks_csv_to_record(%s,%s)
d(owner text, date_and_time timestamp, place text, condition text, status bool, partner text, time_of_selection timestamp,
sport smallint, uploaded_file text, raster oid, raster_small oid, challenge_id text
) where v1_dna_%s.key = %s',$3,$2,$2,$3,$2,$3);
EXECUTE format('insert into %s_c0_%s select * from tmp',$1,$2);

elsif ($1 = 'matches' or $1 = 'doubles') then

EXECUTE format('create temp table tmp on commit drop as select %s, d.*  
from v1_dna_%s, rocks_csv_to_record(%s,%s)
d(tournir_id smallint, round text, match_num_in_round smallint, participant1 text, participant2 text,
score text, winner bool, match_date date, court_type text, court_location text, points_winner smallint,
points_loser smallint, part1_status bool, part2_status bool, date_and_time timestamp, deadline_date date,
comments text, total_time float, sport smallint         
) where v1_dna_%s.key = %s',$3,$2,$2,$3,$2,$3);
EXECUTE format('insert into %s_c0_%s select * from tmp',$1,$2);

end if;

EXECUTE format('select rocks_close()');

RETURN 0;

END;$function$

CREATE OR REPLACE FUNCTION public._p_c0(text, integer, integer, integer)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
DECLARE 
r int;
BEGIN

FOR r IN
EXECUTE format('SELECT split_part(table_name,''_'',3)::int FROM information_schema.tables WHERE table_name ~ ''v1_dna_'' and split_part(table_name,''_'',3)::int > %s and split_part(table_name,''_'',3)::int < %s order by split_part(table_name,''_'',3)::
int',$2,$3)
    LOOP
RAISE NOTICE 'Executing _checkout_c0(''%'',%,%):',$1,r,$4;
EXECUTE format('select _checkout_c0(''%s'',%s,%s)',$1,r,$4) into r;

    END LOOP;
RETURN 0;

END;$function$

CREATE OR REPLACE FUNCTION public._w_new_row()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

DECLARE
v bigint := 0;
rev_old int := 1;
payload text;
vc text;

BEGIN

IF (TG_OP = 'INSERT') THEN

EXECUTE 'select rocks_get_node_number()' into v;
RAISE NOTICE 'new key(''%''):',NEW.key;
IF (v = floor(NEW.key/10000000000000000)) THEN

drop table if exists tmp;
CREATE TEMP TABLE tmp on commit drop as select NEW.*;
ALTER TABLE tmp drop column key;
EXECUTE format('select row_to_csv_rocks(%s,tmp) from tmp',TG_ARGV[1]) into v;
EXECUTE format('select rocks_close()');

EXECUTE format('select cast(%s as text)',v) into vc;
payload := (SELECT TG_ARGV[1] || ',' || json_build_object('tab',TG_ARGV[0],'rev',1,'key',vc) );
  perform pg_notify('v1_dna_insert', payload); 

EXECUTE format('insert into v1_dna_%s (tab, rev, key) values(''%s'',1,%s)',TG_ARGV[1],TG_ARGV[0],v);
NEW.key = v;

END IF;
RETURN NEW;

ELSIF (TG_OP = 'UPDATE') THEN
drop table if exists tmp;
CREATE TEMP TABLE tmp on commit drop as select NEW.*;
ALTER TABLE tmp drop column key;
EXECUTE format('select row_to_csv_rocks(%s,tmp) from tmp',TG_ARGV[1]) into v;
EXECUTE format('select rocks_close()');
EXECUTE format('select rev from v1_dna_%s where key = %s',TG_ARGV[1],NEW.key) into rev_old;

EXECUTE format('select cast(%s as text)',v) into vc;
payload := (SELECT TG_ARGV[1] || ',' || json_build_object('tab',TG_ARGV[0],'rev',rev_old+1,'key',vc) );
  perform pg_notify('v1_dna_insert', payload);

EXECUTE format('insert into v1_dna_%s (tab, rev, key) values (''%s'',%s,%s)',TG_ARGV[1],TG_ARGV[0],rev_old+1,v);

EXECUTE format('select cast(%s as text)',NEW.key) into vc;
payload := (SELECT TG_ARGV[1] || ',' || json_build_object('tab',TG_ARGV[0],'rev',rev_old*(-1),'key',vc) );
perform pg_notify('v1_dna_update', payload); 

EXECUTE format('update v1_dna_%s set rev = %s where key = %s',TG_ARGV[1],rev_old*(-1),NEW.key);

NEW.key = v;
RETURN NEW;

ELSIF (TG_OP = 'DELETE') THEN

EXECUTE format('select rev from v1_dna_%s where key = %s',TG_ARGV[1],OLD.key) into rev_old;

IF (rev_old > 0) THEN

EXECUTE format('select cast(%s as text)',OLD.key) into vc;
payload := (SELECT TG_ARGV[1] || ',' || json_build_object('tab',TG_ARGV[0],'rev',0,'key',vc) );
perform pg_notify('v1_dna_update', payload); 

EXECUTE format('update v1_dna_%s set rev = 0 where key = %s',TG_ARGV[1],OLD.key);

END IF;

RETURN OLD;
END IF;

END;$function$

CREATE OR REPLACE FUNCTION public.hex_to_int(hexval character varying)
 RETURNS integer
 LANGUAGE plpgsql
 IMMUTABLE STRICT
AS $function$
DECLARE
    result  int;
BEGIN
    EXECUTE 'SELECT x''' || hexval || '''::int' INTO result;
    RETURN result;
END;
$function$

CREATE OR REPLACE FUNCTION public._checkout_c0(text, integer, integer)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
DECLARE 
    start_sym text;
BEGIN

if ($1 = 'challenges' or $1 = 'matches' or $1 = 'doubles') then
start_sym = $1;
else 
RETURN -1;
end if;

if $3 = 1 then 
EXECUTE format('drop table if exists %s_c0_%s',start_sym,$2); 
end if;

if $1 = 'challenges' then

EXECUTE format('create table if not exists challenges_c0_%s with oids as select key, d.*  
from v1_dna_%s, rocks_csv_to_record(%s,v1_dna_%s.key) 
d(owner text, date_and_time timestamp, place text, condition text, status bool, partner text, time_of_selection timestamp,
sport smallint, uploaded_file text, raster oid, raster_small oid, challenge_id text
) where v1_dna_%s.rev  > 0 and v1_dna_%s.tab = ''challenges''',$2,$2,$2,$2,$2,$2);


elsif ($1 = 'matches' or $1 = 'doubles') then

EXECUTE format('create table if not exists %s_c0_%s  with oids as select key, d.*  
from v1_dna_%s, rocks_csv_to_record(%s,v1_dna_%s.key) 
d(tournir_id smallint, round text, match_num_in_round smallint, participant1 text, participant2 text,
score text, winner bool, match_date date, court_type text, court_location text, points_winner smallint,
points_loser smallint, part1_status bool, part2_status bool, date_and_time timestamp, deadline_date date,
comments text, total_time float, sport smallint         
) where v1_dna_%s.rev  > 0 and v1_dna_%s.tab = ''%s''',$1,$2,$2,$2,$2,$2,$2,$1);

end if;

  
EXECUTE format('select rocks_close()');

EXECUTE format('CREATE TRIGGER %s_c0_%s_i
BEFORE INSERT OR UPDATE OR DELETE 
ON %s_c0_%s
FOR EACH ROW
EXECUTE PROCEDURE _w_new_row(''%s'',%s);',$1,$2,$1,$2,$1,$2);


RETURN 0;

END;$function$

CREATE OR REPLACE FUNCTION public.get_participant1(oid)
 RETURNS text
 LANGUAGE sql
AS $function$select participant1 from matches where oid = $1
$function$;

CREATE OR REPLACE FUNCTION public.get_participant2(oid)
 RETURNS text
 LANGUAGE sql
AS $function$select participant2 from matches where oid = $1
$function$;

CREATE OR REPLACE FUNCTION public.get_winner1(oid)
 RETURNS text
 LANGUAGE sql
AS $function$select participant1 from matches where oid = $1 
and winner='t'$function$;

CREATE OR REPLACE FUNCTION public.get_loser1(oid)
 RETURNS text
 LANGUAGE sql
AS $function$select participant1 from matches where oid = $1 
and winner='f'$function$;

CREATE OR REPLACE FUNCTION public.get_loser2(oid)
 RETURNS text
 LANGUAGE sql
AS $function$select participant2 from matches where oid = $1 
and winner='t'$function$;

CREATE OR REPLACE FUNCTION public.get_winner2(oid)
 RETURNS text
 LANGUAGE sql
AS $function$select participant2 from matches where oid = $1 
and winner='f'$function$;

CREATE OR REPLACE FUNCTION public.real_winner(oid)
 RETURNS text
 LANGUAGE sql
AS $function$select case when get_winner1($1) is null and get_loser1($1) is not null then get_winner2($1)
else case when get_winner2($1) is null and get_loser2($1) is not null then get_winner1($1)
else get_participant1($1) end end$function$;

CREATE OR REPLACE FUNCTION public.real_loser(oid)
 RETURNS text
 LANGUAGE sql
AS $function$select case when get_winner1($1) is null and get_loser1($1) is not null then get_loser1($1)
else case when get_winner2($1) is null and get_loser2($1) is not null then get_loser2($1)
else get_participant2($1) end end$function$;

CREATE OR REPLACE FUNCTION public.a_nkname(text, bool)
 RETURNS text
 LANGUAGE sql
AS $function$select case when $2 is null then concat(a_nkname, ' ') else a_nkname end from members where proj_code = $1
$function$;

CREATE OR REPLACE FUNCTION public.w_a_nkname(text, bool)
 RETURNS text
 LANGUAGE sql
AS $function$select case when a_nkname($1, $2) is null then $1 else a_nkname($1, $2) end
$function$;

CREATE OR REPLACE FUNCTION public.courts_name(text)
 RETURNS text
 LANGUAGE sql
AS $function$select a_name from courts_location where oid::text = $1
$function$;

CREATE OR REPLACE FUNCTION public.w_court_type(text)
 RETURNS text
 LANGUAGE sql
AS $function$select replace(replace(replace($1,'brick','грунт'),'hard','хард'),'taraflex','тарафлекс')
$function$;

CREATE OR REPLACE FUNCTION public.w_match_type(smallint)
 RETURNS text
 LANGUAGE sql
AS $function$select case when match_type($1) is null then 'индивидуальный' else match_type($1) end
$function$;

CREATE OR REPLACE FUNCTION public.match_type(smallint)
 RETURNS text
 LANGUAGE sql
AS $function$select description from tournir_info where tournir_id = $1
$function$;

