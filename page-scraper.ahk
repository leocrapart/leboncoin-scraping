; given a page url, extract :
; phone
; ...

goToUrl("https://www.leboncoin.fr/ventes_immobilieres/2271109727.htm")
scrapePage()


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
	MouseClickDrag left, 1065, 280, 1310, 320
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

