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

------------------------
---------------------- doubles

CREATE OR REPLACE FUNCTION public.get_doubles_participant1(oid)
 RETURNS text
 LANGUAGE sql
AS $function$select participant1 from doubles where oid = $1
$function$;

CREATE OR REPLACE FUNCTION public.get_doubles_participant2(oid)
 RETURNS text
 LANGUAGE sql
AS $function$select participant2 from doubles where oid = $1
$function$;

CREATE OR REPLACE FUNCTION public.get_doubles_winner1(oid)
 RETURNS text
 LANGUAGE sql
AS $function$select participant1 from doubles where oid = $1 
and winner='t'$function$;

CREATE OR REPLACE FUNCTION public.get_doubles_loser1(oid)
 RETURNS text
 LANGUAGE sql
AS $function$select participant1 from doubles where oid = $1 
and winner='f'$function$;

CREATE OR REPLACE FUNCTION public.get_doubles_loser2(oid)
 RETURNS text
 LANGUAGE sql
AS $function$select participant2 from doubles where oid = $1 
and winner='t'$function$;

CREATE OR REPLACE FUNCTION public.get_doubles_winner2(oid)
 RETURNS text
 LANGUAGE sql
AS $function$select participant2 from doubles where oid = $1 
and winner='f'$function$;

CREATE OR REPLACE FUNCTION public.real_doubles_winner(oid)
 RETURNS text
 LANGUAGE sql
AS $function$select case when get_doubles_winner1($1) is null and get_doubles_loser1($1) is not null then get_doubles_winner2($1)
else case when get_doubles_winner2($1) is null and get_doubles_loser2($1) is not null then get_doubles_winner1($1)
else get_doubles_participant1($1) end end$function$;

CREATE OR REPLACE FUNCTION public.real_doubles_loser(oid)
 RETURNS text
 LANGUAGE sql
AS $function$select case when get_doubles_winner1($1) is null and get_doubles_loser1($1) is not null then get_doubles_loser1($1)
else case when get_doubles_winner2($1) is null and get_doubles_loser2($1) is not null then get_doubles_loser2($1)
else get_doubles_participant2($1) end end$function$;

CREATE OR REPLACE FUNCTION public.a_doubles_nknames(text, bool)
 RETURNS text
 LANGUAGE sql
AS $function$select array_to_string(ARRAY(select w_a_nkname(unnest(string_to_array($1,'/')), $2)),'/')
$function$;

CREATE OR REPLACE FUNCTION public.w_a_doubles_nknames(text, bool)
 RETURNS text
 LANGUAGE sql
AS $function$select case when a_doubles_nknames($1, $2) is null then $1 else a_doubles_nknames($1, $2) end
$function$;
