namespace :task_sample do
  desc "【Yahoo!天気】東京の天気"
  task :weather_in_tokyo do
    driver = Selenium::WebDriver.for :chrome
    driver.get 'https://weather.yahoo.co.jp/weather/jp/13/4410.html'

    el = driver.find_element(:id, 'yjw_week')
    driver.execute_script("window.scroll(0,#{el.location.y});")

    puts driver.find_element(:id, "week").text.gsub(/\R/, " ")

    table = el.find_element(:css, '.yjw_table')
    tr_cnt = table.find_elements(:tag_name, 'tr').size()
    td_cnt = table.find_element(:tag_name, 'tr').find_elements(:tag_name, 'td').size()

    # xpath //*[@id="yjw_week"]/table/tbody/tr[1]/tr[1]
    for i in 1 .. td_cnt
      for j in 1 .. tr_cnt
        print driver.find_element(:xpath, "//*[@id='yjw_week']/table/tbody/tr[#{j}]/td[#{i}]" ).text.gsub(/\R/, " ")
        print "," if j != tr_cnt
      end
      puts ""
    end

    driver.quit()
  end
end