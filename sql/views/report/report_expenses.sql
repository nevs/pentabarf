
CREATE OR REPLACE VIEW view_report_expenses AS
  SELECT person_id,
         view_person.name,
         conference_id,
         travel_cost,
         travel_currency_id,
         travel_currency.name AS travel_currency_name,
         accommodation_cost,
         accommodation_currency_id,
         accommodation_currency.name AS accommodation_currency_name,
         fee,
         fee_currency_id,
         fee_currency.name AS fee_currency_name,
         travel_currency.language_id
    FROM person_travel
         INNER JOIN view_person USING (person_id)
         INNER JOIN view_currency AS travel_currency ON (
             person_travel.travel_currency_id = travel_currency.currency_id)
         INNER JOIN view_currency AS accommodation_currency ON (
             person_travel.accommodation_currency_id = accommodation_currency.currency_id AND
             accommodation_currency.language_id = travel_currency.language_id)
         INNER JOIN view_currency AS fee_currency ON (
             person_travel.fee_currency_id = fee_currency.currency_id AND
             fee_currency.language_id = travel_currency.language_id)
   WHERE ( ( f_need_travel_cost = 't' AND
             travel_cost IS NOT NULL ) OR
           ( f_need_accommodation_cost = 't' AND
             accommodation_cost IS NOT NULL ) OR
           fee IS NOT NULL )
;

