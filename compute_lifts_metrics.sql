--Final: Test Write Up 14 Jan 2024 (Data Wrangling, Analysis and AB Testing with SQL) UC-Davis
SELECT 
    test_assignment, 
    test_number,
    COUNT(DISTINCT item) AS number_of_items,
    SUM(binary_30d) AS binary_30d
FROM
    (SELECT 
        fa.item_id AS item, 
        test_assignment, 
        test_number,
        test_start_date,
        MAX((CASE
            WHEN date(event_time) - date(test_start_date) BETWEEN 0 AND 30 THEN 1 ELSE 0
            END)) AS binary_30d
    FROM dsv1069.final_assignments AS fa
    LEFT JOIN dsv1069.view_item_events AS view_events ON fa.item_id = view_events.item_id
    WHERE test_number = 'item_test_2'
    GROUP BY 
        fa.item_id, 
        test_assignment, 
        test_number,
        test_start_date) AS view_binary
GROUP BY 
    test_assignment, 
    test_number, 
    test_start_date
LIMIT 100;
