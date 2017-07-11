INSERT INTO disc_cards
(discount_id,barcode)
(
SELECT 2,'915000000'::text||
substr('000',1,3-length(ser::text))||
ser::text
FROM generate_series(1, 100) AS ser
)
