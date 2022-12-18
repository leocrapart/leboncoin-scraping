CoordMode, Mouse, Screen
#Include tf.ahk
; find a way to 
; readTxt(filename) -> vector/list of all urls
; 
; spit page-data in excel modifying it
; addRow(excelFilename, row)
; row = vector/list of the page-data
; pageDataToRow(pageData)
; 
; read urls
; 	scrape page
; 	add to excel
; 	scrape page
; 	add to excel
; 	etc...
; finished

^t::main()
^y::msgbox % url(2)

url(n) {
	txtFilename := "C:\Users\leocr\Desktop\leboncoin-scraping\urls.txt"
	url := TF_ReadLines(txtFilename, n, n)
	return url
}

urls() {
	return TF_ReadLines("C:\Users\leocr\Desktop\leboncoin-scraping\urls.txt")
}
	

main() {
	; read urls.txt
	; first url
	goToUrl("https://www.leboncoin.fr/ventes_immobilieres/2271109727.htm")
	pageData := scrapePage()
	; savePageData(pageData)
	; loop
	showFinished()
}


savePageData() {
	; save page data into scraped-data.xlsx which already exists
	; number  title  company  siret  url
	; 
	; modify excel file lib
}

scrapePage() {
	pageData := {}

	; voir le numéro
	click 1150, 500
	sleep 1000

	; annuler popup
	click 1045, 218
	sleep 1000

	; select number
	sleep 1000
	MouseClickDrag left, 1350, 500, 970, 500
	sleep 1000

	; store number
	send ^c
	sleep 100
	number := % Clipboard
	pageData.number := number
	sleep 1000

	; select url
	click 1000, 50
	sleep 1000

	; store url
	send ^c
	sleep 100
	url := % Clipboard
	pageData.url := url
	sleep 1000

	; select title ?
	MouseClickDrag left, 250, 600, 620, 720
	sleep 1000

	; store title
	send ^c
	sleep 100
	title := % Clipboard
	pageData.title := title
	sleep 1000

	; select company
	MouseClickDrag left, 1067, 278, 1313, 279
	sleep 1000

	; store company
	send ^c
	sleep 100
	company := % Clipboard
	pageData.company := company
	sleep 1000

	; select siret
	click 1150, 350
	sleep 100
	click 1150, 350
	sleep 1000
	
	; store siret
	send ^c
	sleep 100
	siret := % Clipboard
	pageData.siret := siret

	msgbox % number
	msgbox % url
	msgbox % title
	msgbox % company
	msgbox % siret
	return pageData
}

goToUrl(url) {
	; click urlbar
	click 580, 50
	paste(url)
	send {enter}
	sleep 5000
}

showFinished() {
	MouseMove 62, 112
}

paste(text) {
  clipboard = %text%
  sleep 500
  send ^v
  sleep 500
  return
}

copy() {
	send ^c
	return
}

ESC::ExitApp