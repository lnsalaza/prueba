def properati(link)
  dataHTML = URI.open(link)
	parsed = Nokogiri::HTML(dataHTML.read)
	houseList = parsed.css('.Xbqhe')
	houseList.css('.gxrAFy').each do |house|
		name = house.css('.jGXOiG .cSLJrQ').inner_text
		@price = house.css('.jGXOiG .hQvubf').inner_text
		@location = ''
		house.css('.jGXOiG .dxIVBd').inner_text.split(',').each do |loc|
			@location += "#{loc};"
		end
		@detailsArray = ''
		house.css('.jGXOiG .kbmWJE span').each do |details|
			@detailsArray += "#{details.inner_text};"
		end
		@seller = house.css('.jGXOiG .seller-name').inner_text
		@publicationDate = house.css('.jGXOiG .hFXCBX').inner_text
		@detailurl = house.css('.jGXOiG a').attr('href')
		@detailLink = "https://www.properati.com.ec#{@detailurl}"

		CSV.open('outputCSV/properati.csv', 'a') do |csv|
	    csv << %w[name @price @location @detailsArray.to_s @seller @publicationDate]
  	end
	end
end
