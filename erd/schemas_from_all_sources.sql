CREATE TABLE dbo.call_center(
	cc_call_center_sk int NULL,
	cc_call_center_id nvarchar(max) NULL,
	cc_rec_start_date date NULL,
	cc_rec_end_date date NULL,
	cc_closed_date_sk int NULL,
	cc_open_date_sk int NULL,
	cc_name nvarchar(max) NULL,
	cc_class nvarchar(max) NULL,
	cc_employees int NULL,
	cc_sq_ft int NULL,
	cc_hours nvarchar(max) NULL,
	cc_manager nvarchar(max) NULL,
	cc_mkt_id int NULL,
	cc_mkt_class nvarchar(max) NULL,
	cc_mkt_desc nvarchar(max) NULL,
	cc_market_manager nvarchar(max) NULL,
	cc_division int NULL,
	cc_division_name nvarchar(max) NULL,
	cc_company int NULL,
	cc_company_name nvarchar(max) NULL,
	cc_street_number nvarchar(max) NULL,
	cc_street_name nvarchar(max) NULL,
	cc_street_type nvarchar(max) NULL,
	cc_suite_number nvarchar(max) NULL,
	cc_city nvarchar(max) NULL,
	cc_county nvarchar(max) NULL,
	cc_state nvarchar(max) NULL,
	cc_zip nvarchar(max) NULL,
	cc_country nvarchar(max) NULL,
	cc_gmt_offset decimal(5, 2) NULL,
	cc_tax_percentage decimal(5, 2) NULL
) ON PRIMARY TEXTIMAGE_ON PRIMARY
GO

CREATE TABLE dbo.catalog_page(
	cp_catalog_page_sk int NULL,
	cp_catalog_page_id nvarchar(max) NULL,
	cp_start_date_sk int NULL,
	cp_end_date_sk int NULL,
	cp_department nvarchar(max) NULL,
	cp_catalog_number int NULL,
	cp_catalog_page_number int NULL,
	cp_description nvarchar(max) NULL,
	cp_type nvarchar(max) NULL
) ON PRIMARY TEXTIMAGE_ON PRIMARY
GO

CREATE TABLE dbo.catalog_returns(
	cr_returned_time_sk int NULL,
	cr_item_sk int NULL,
	cr_refunded_customer_sk int NULL,
	cr_refunded_cdemo_sk int NULL,
	cr_refunded_hdemo_sk int NULL,
	cr_refunded_addr_sk int NULL,
	cr_returning_customer_sk int NULL,
	cr_returning_cdemo_sk int NULL,
	cr_returning_hdemo_sk int NULL,
	cr_returning_addr_sk int NULL,
	cr_call_center_sk int NULL,
	cr_catalog_page_sk int NULL,
	cr_ship_mode_sk int NULL,
	cr_warehouse_sk int NULL,
	cr_reason_sk int NULL,
	cr_order_number bigint NULL,
	cr_return_quantity int NULL,
	cr_return_amount decimal(7, 2) NULL,
	cr_return_tax decimal(7, 2) NULL,
	cr_return_amt_inc_tax decimal(7, 2) NULL,
	cr_fee decimal(7, 2) NULL,
	cr_return_ship_cost decimal(7, 2) NULL,
	cr_refunded_cash decimal(7, 2) NULL,
	cr_reversed_charge decimal(7, 2) NULL,
	cr_store_credit decimal(7, 2) NULL,
	cr_net_loss decimal(7, 2) NULL,
	cr_returned_date_sk int NULL
) ON PRIMARY
GO

CREATE TABLE dbo.catalog_sales(
	cs_sold_time_sk int NULL,
	cs_ship_date_sk int NULL,
	cs_bill_customer_sk int NULL,
	cs_bill_cdemo_sk int NULL,
	cs_bill_hdemo_sk int NULL,
	cs_bill_addr_sk int NULL,
	cs_ship_customer_sk int NULL,
	cs_ship_cdemo_sk int NULL,
	cs_ship_hdemo_sk int NULL,
	cs_ship_addr_sk int NULL,
	cs_call_center_sk int NULL,
	cs_catalog_page_sk int NULL,
	cs_ship_mode_sk int NULL,
	cs_warehouse_sk int NULL,
	cs_item_sk int NULL,
	cs_promo_sk int NULL,
	cs_order_number bigint NULL,
	cs_quantity int NULL,
	cs_wholesale_cost decimal(7, 2) NULL,
	cs_list_price decimal(7, 2) NULL,
	cs_sales_price decimal(7, 2) NULL,
	cs_ext_discount_amt decimal(7, 2) NULL,
	cs_ext_sales_price decimal(7, 2) NULL,
	cs_ext_wholesale_cost decimal(7, 2) NULL,
	cs_ext_list_price decimal(7, 2) NULL,
	cs_ext_tax decimal(7, 2) NULL,
	cs_coupon_amt decimal(7, 2) NULL,
	cs_ext_ship_cost decimal(7, 2) NULL,
	cs_net_paid decimal(7, 2) NULL,
	cs_net_paid_inc_tax decimal(7, 2) NULL,
	cs_net_paid_inc_ship decimal(7, 2) NULL,
	cs_net_paid_inc_ship_tax decimal(7, 2) NULL,
	cs_net_profit decimal(7, 2) NULL,
	cs_sold_date_sk int NULL
) ON PRIMARY
GO

CREATE TABLE dbo.customer(
	c_customer_sk int NULL,
	c_customer_id nvarchar(max) NULL,
	c_current_cdemo_sk int NULL,
	c_current_hdemo_sk int NULL,
	c_current_addr_sk int NULL,
	c_first_shipto_date_sk int NULL,
	c_first_sales_date_sk int NULL,
	c_salutation nvarchar(max) NULL,
	c_first_name nvarchar(max) NULL,
	c_last_name nvarchar(max) NULL,
	c_preferred_cust_flag nvarchar(max) NULL,
	c_birth_day int NULL,
	c_birth_month int NULL,
	c_birth_year int NULL,
	c_birth_country nvarchar(max) NULL,
	c_login nvarchar(max) NULL,
	c_email_address nvarchar(max) NULL,
	c_last_review_date nvarchar(max) NULL
) ON PRIMARY TEXTIMAGE_ON PRIMARY
GO

CREATE TABLE dbo.customer_address(
	ca_address_sk int NULL,
	ca_address_id nvarchar(max) NULL,
	ca_street_number nvarchar(max) NULL,
	ca_street_name nvarchar(max) NULL,
	ca_street_type nvarchar(max) NULL,
	ca_suite_number nvarchar(max) NULL,
	ca_city nvarchar(max) NULL,
	ca_county nvarchar(max) NULL,
	ca_state nvarchar(max) NULL,
	ca_zip nvarchar(max) NULL,
	ca_country nvarchar(max) NULL,
	ca_gmt_offset decimal(5, 2) NULL,
	ca_location_type nvarchar(max) NULL
) ON PRIMARY TEXTIMAGE_ON PRIMARY
GO

CREATE TABLE dbo.customer_demographics(
	cd_demo_sk int NULL,
	cd_gender nvarchar(max) NULL,
	cd_marital_status nvarchar(max) NULL,
	cd_education_status nvarchar(max) NULL,
	cd_purchase_estimate int NULL,
	cd_credit_rating nvarchar(max) NULL,
	cd_dep_count int NULL,
	cd_dep_employed_count int NULL,
	cd_dep_college_count int NULL
) ON PRIMARY TEXTIMAGE_ON PRIMARY
GO

CREATE TABLE date_dim (
    d_date_sk BIGINT PRIMARY KEY,
    d_current_day NVARCHAR(MAX),
    d_current_month NVARCHAR(MAX),
    d_current_quarter NVARCHAR(MAX),
    d_current_week NVARCHAR(MAX),
    d_current_year NVARCHAR(MAX),
    d_date NVARCHAR(MAX),
    d_date_id NVARCHAR(MAX),
    d_day_name NVARCHAR(MAX),
    d_dom BIGINT,
    d_dow BIGINT,
    d_first_dom BIGINT,
    d_following_holiday NVARCHAR(MAX),
    d_fy_quarter_seq BIGINT,
    d_fy_week_seq BIGINT,
    d_fy_year BIGINT,
    d_holiday NVARCHAR(MAX),
    d_last_dom BIGINT,
    d_month_seq BIGINT,
    d_moy BIGINT,
    d_qoy BIGINT,
    d_quarter_name NVARCHAR(MAX),
    d_quarter_seq BIGINT,
    d_same_day_lq BIGINT,
    d_same_day_ly BIGINT,
    d_week_seq BIGINT,
    d_weekend NVARCHAR(MAX),
    d_year BIGINT
);
GO

CREATE TABLE household_demographics (
    hd_demo_sk INT,
    hd_income_band_sk INT,
    hd_buy_potential NVARCHAR(MAX),
    hd_dep_count INT,
    hd_vehicle_count INT
);
GO

CREATE TABLE income_band (
    ib_income_band_sk BIGINT,
    ib_lower_bound BIGINT,
    ib_upper_bound BIGINT
);
GO

CREATE TABLE inventory (
    inv_date_sk INT,
    inv_item_sk INT,
    inv_warehouse_sk INT,
    inv_quantity_on_hand INT
);
GO

CREATE TABLE item (
    i_brand NVARCHAR(MAX),
    i_brand_id BIGINT,
    i_category NVARCHAR(MAX),
    i_category_id BIGINT,
    i_class NVARCHAR(MAX),
    i_class_id BIGINT,
    i_color NVARCHAR(MAX),
    i_container NVARCHAR(MAX),
    i_current_price FLOAT,
    i_formulation NVARCHAR(MAX),
    i_item_desc NVARCHAR(MAX),
    i_item_id NVARCHAR(MAX),
    i_item_sk BIGINT,
    i_manager_id BIGINT,
    i_manufact NVARCHAR(MAX),
    i_manufact_id BIGINT,
    i_product_name NVARCHAR(MAX),
    i_rec_end_date NVARCHAR(MAX),
    i_rec_start_date NVARCHAR(MAX),
    i_size NVARCHAR(MAX),
    i_units NVARCHAR(MAX),
    i_wholesale_cost FLOAT
);
GO

CREATE TABLE promotion (
    p_channel_catalog NVARCHAR(MAX),
    p_channel_demo NVARCHAR(MAX),
    p_channel_details NVARCHAR(MAX),
    p_channel_dmail NVARCHAR(MAX),
    p_channel_email NVARCHAR(MAX),
    p_channel_event NVARCHAR(MAX),
    p_channel_press NVARCHAR(MAX),
    p_channel_radio NVARCHAR(MAX),
    p_channel_tv NVARCHAR(MAX),
    p_cost FLOAT,
    p_discount_active NVARCHAR(MAX),
    p_end_date_sk BIGINT,
    p_item_sk BIGINT,
    p_promo_id NVARCHAR(MAX),
    p_promo_name NVARCHAR(MAX),
    p_promo_sk BIGINT,
    p_purpose NVARCHAR(MAX),
    p_response_target BIGINT,
    p_start_date_sk BIGINT
);
GO

CREATE TABLE dbo.reason(
	reason_code int IDENTITY(1,1) NOT NULL,
	description varchar(max) NOT NULL
) ON PRIMARY TEXTIMAGE_ON PRIMARY
GO

CREATE TABLE ship_mode (
    sm_carrier NVARCHAR(MAX),
    sm_code NVARCHAR(MAX),
    sm_contract NVARCHAR(MAX),
    sm_ship_mode_id NVARCHAR(MAX),
    sm_ship_mode_sk BIGINT,
    sm_type NVARCHAR(MAX)
);
GO

CREATE TABLE store (
    s_city NVARCHAR(MAX),
    s_closed_date_sk BIGINT,
    s_company_id BIGINT,
    s_company_name NVARCHAR(MAX),
    s_country NVARCHAR(MAX),
    s_county NVARCHAR(MAX),
    s_division_id BIGINT,
    s_division_name NVARCHAR(MAX),
    s_floor_space BIGINT,
    s_geography_class NVARCHAR(MAX),
    s_gmt_offset FLOAT,
    s_hours NVARCHAR(MAX),
    s_manager NVARCHAR(MAX),
    s_market_desc NVARCHAR(MAX),
    s_market_id BIGINT,
    s_market_manager NVARCHAR(MAX),
    s_number_employees BIGINT,
    s_rec_end_date NVARCHAR(MAX),
    s_rec_start_date NVARCHAR(MAX),
    s_state NVARCHAR(MAX),
    s_store_id NVARCHAR(MAX),
    s_store_name NVARCHAR(MAX),
    s_store_sk BIGINT,
    s_street_name NVARCHAR(MAX),
    s_street_number NVARCHAR(MAX),
    s_street_type NVARCHAR(MAX),
    s_suite_number NVARCHAR(MAX),
    s_tax_percentage FLOAT,
    s_zip NVARCHAR(MAX)
);
GO

CREATE TABLE store_returns (
    sr_returned_date_sk INT,
    sr_return_time_sk INT,
    sr_item_sk INT,
    sr_customer_sk INT,
    sr_cdemo_sk INT,
    sr_hdemo_sk INT,
    sr_addr_sk INT,
    sr_store_sk INT,
    sr_reason_sk INT,
    sr_ticket_number INT,
    sr_return_quantity INT,
    sr_return_amt DECIMAL(7,2),
    sr_return_tax DECIMAL(7,2),
    sr_return_amt_inc_tax DECIMAL(7,2),
    sr_fee DECIMAL(7,2),
    sr_return_ship_cost DECIMAL(7,2),
    sr_refunded_cash DECIMAL(7,2),
    sr_reversed_charge DECIMAL(7,2),
    sr_store_credit DECIMAL(7,2),
    sr_net_loss DECIMAL(7,2)
);
GO

CREATE TABLE store_sales (
    ss_sold_date_sk INT,
    ss_sold_time_sk INT,
    ss_item_sk INT,
    ss_customer_sk INT,
    ss_cdemo_sk INT,
    ss_hdemo_sk INT,
    ss_addr_sk INT,
    ss_store_sk INT,
    ss_promo_sk INT,
    ss_ticket_number INT,
    ss_quantity INT,
    ss_wholesale_cost DECIMAL(7,2),
    ss_list_price DECIMAL(7,2),
    ss_sales_price DECIMAL(7,2),
    ss_ext_discount_amt DECIMAL(7,2),
    ss_ext_sales_price DECIMAL(7,2),
    ss_ext_wholesale_cost DECIMAL(7,2),
    ss_ext_list_price DECIMAL(7,2),
    ss_ext_tax DECIMAL(7,2),
    ss_coupon_amt DECIMAL(7,2),
    ss_net_paid DECIMAL(7,2),
    ss_net_paid_inc_tax DECIMAL(7,2),
    ss_net_profit DECIMAL(7,2)
);
GO

CREATE TABLE time_dim (
    t_time_sk BIGINT PRIMARY KEY,
    t_am_pm NVARCHAR(MAX),
    t_hour BIGINT,
    t_meal_time NVARCHAR(MAX),
    t_minute BIGINT,
    t_second BIGINT,
    t_shift NVARCHAR(MAX),
    t_sub_shift NVARCHAR(MAX),
    t_time BIGINT,
    t_time_id NVARCHAR(MAX)
);
GO

CREATE TABLE warehouse (
    w_city NVARCHAR(MAX),
    w_country NVARCHAR(MAX),
    w_county NVARCHAR(MAX),
    w_gmt_offset FLOAT,
    w_state NVARCHAR(MAX),
    w_street_name NVARCHAR(MAX),
    w_street_number NVARCHAR(MAX),
    w_street_type NVARCHAR(MAX),
    w_suite_number NVARCHAR(MAX),
    w_warehouse_id NVARCHAR(MAX),
    w_warehouse_name NVARCHAR(MAX),
    w_warehouse_sk BIGINT,
    w_warehouse_sq_ft BIGINT,
    w_zip NVARCHAR(MAX)
);
GO

CREATE TABLE web_page (
    wp_access_date_sk BIGINT,
    wp_autogen_flag NVARCHAR(MAX),
    wp_char_count BIGINT,
    wp_creation_date_sk BIGINT,
    wp_customer_sk BIGINT,
    wp_image_count BIGINT,
    wp_link_count BIGINT,
    wp_max_ad_count BIGINT,
    wp_rec_end_date NVARCHAR(MAX),
    wp_rec_start_date NVARCHAR(MAX),
    wp_type NVARCHAR(MAX),
    wp_url NVARCHAR(MAX),
    wp_web_page_id NVARCHAR(MAX),
    wp_web_page_sk BIGINT
);
GO

CREATE TABLE web_returns (
    wr_account_credit FLOAT,
    wr_fee FLOAT,
    wr_item_sk BIGINT,
    wr_net_loss FLOAT,
    wr_order_number BIGINT,
    wr_reason_sk BIGINT,
    wr_refunded_addr_sk BIGINT,
    wr_refunded_cash FLOAT,
    wr_refunded_cdemo_sk BIGINT,
    wr_refunded_customer_sk BIGINT,
    wr_refunded_hdemo_sk BIGINT,
    wr_return_amt FLOAT,
    wr_return_amt_inc_tax FLOAT,
    wr_return_quantity BIGINT,
    wr_return_ship_cost FLOAT,
    wr_return_tax FLOAT,
    wr_returned_date_sk BIGINT,
    wr_returned_time_sk BIGINT,
    wr_returning_addr_sk BIGINT,
    wr_returning_cdemo_sk BIGINT,
    wr_returning_customer_sk BIGINT,
    wr_returning_hdemo_sk BIGINT,
    wr_reversed_charge FLOAT,
    wr_web_page_sk BIGINT
);
GO

CREATE TABLE web_sales (
    ws_sold_date_sk INT,
    ws_sold_time_sk INT,
    ws_ship_date_sk INT,
    ws_item_sk INT,
    ws_bill_customer_sk INT,
    ws_bill_cdemo_sk INT,
    ws_bill_hdemo_sk INT,
    ws_bill_addr_sk INT,
    ws_ship_customer_sk INT,
    ws_ship_cdemo_sk INT,
    ws_ship_hdemo_sk INT,
    ws_ship_addr_sk INT,
    ws_web_page_sk INT,
    ws_web_site_sk INT,
    ws_ship_mode_sk INT,
    ws_warehouse_sk INT,
    ws_promo_sk INT,
    ws_order_number INT,
    ws_quantity INT,
    ws_wholesale_cost DECIMAL(7,2),
    ws_list_price DECIMAL(7,2),
    ws_sales_price DECIMAL(7,2),
    ws_ext_discount_amt DECIMAL(7,2),
    ws_ext_sales_price DECIMAL(7,2),
    ws_ext_wholesale_cost DECIMAL(7,2),
    ws_ext_list_price DECIMAL(7,2),
    ws_ext_tax DECIMAL(7,2),
    ws_coupon_amt DECIMAL(7,2),
    ws_ext_ship_cost DECIMAL(7,2),
    ws_net_paid DECIMAL(7,2),
    ws_net_paid_inc_tax DECIMAL(7,2),
    ws_net_paid_inc_ship DECIMAL(7,2),
    ws_net_paid_inc_ship_tax DECIMAL(7,2),
    ws_net_profit DECIMAL(7,2)
);
GO

ALTER TABLE web_sales
ADD CONSTRAINT FK_web_sales_date_dim
    FOREIGN KEY (ws_sold_date_sk) REFERENCES date_dim(d_date_sk);
GO

ALTER TABLE web_sales
ADD CONSTRAINT FK_web_sales_time_dim
    FOREIGN KEY (ws_sold_time_sk) REFERENCES time_dim(t_time_sk);

ALTER TABLE web_sales
ADD CONSTRAINT FK_web_sales_date_dim
    FOREIGN KEY (ws_ship_date_sk) REFERENCES date_dim(d_date_sk);
GO    

CREATE TABLE web_site (
    web_city NVARCHAR(MAX),
    web_class NVARCHAR(MAX),
    web_close_date_sk BIGINT,
    web_company_id BIGINT,
    web_company_name NVARCHAR(MAX),
    web_country NVARCHAR(MAX),
    web_county NVARCHAR(MAX),
    web_gmt_offset FLOAT,
    web_manager NVARCHAR(MAX),
    web_market_manager NVARCHAR(MAX),
    web_mkt_class NVARCHAR(MAX),
    web_mkt_desc NVARCHAR(MAX),
    web_mkt_id BIGINT,
    web_name NVARCHAR(MAX),
    web_open_date_sk BIGINT,
    web_rec_end_date NVARCHAR(MAX),
    web_rec_start_date NVARCHAR(MAX),
    web_site_id NVARCHAR(MAX),
    web_site_sk BIGINT,
    web_state NVARCHAR(MAX),
    web_street_name NVARCHAR(MAX),
    web_street_number NVARCHAR(MAX),
    web_street_type NVARCHAR(MAX),
    web_suite_number NVARCHAR(MAX),
    web_tax_percentage FLOAT,
    web_zip NVARCHAR(MAX)
);


