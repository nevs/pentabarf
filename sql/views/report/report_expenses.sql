
CREATE OR REPLACE VIEW view_report_expenses AS
  SELECT person_id,
         view_person.name,
         conference_id,
         CASE need_travel_cost WHEN TRUE THEN travel_cost ELSE 0::numeric(16,2) END AS travel_cost,
         travel_currency,
         CASE need_accommodation_cost WHEN TRUE THEN accommodation_cost ELSE 0::numeric(16,2) END AS accommodation_cost,
         accommodation_currency,
         fee,
         fee_currency
    FROM conference_person_travel
         INNER JOIN conference_person USING (conference_person_id)
         INNER JOIN view_person USING (person_id)
   WHERE ( ( need_travel_cost = 't' AND
             travel_cost IS NOT NULL ) OR
           ( need_accommodation_cost = 't' AND
             accommodation_cost IS NOT NULL ) OR
           fee IS NOT NULL )
;

