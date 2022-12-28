(ns leboncoin-scraping.core
  (:gen-class))

(defn -main
  "I don't do a whole lot ... yet."
  [& args]
  (println "Hello, World!"))

;; the clojure code use is :
;; - extract urls from the result pages
;; - and put urls into a text/excel/local db

;; which will then be used by the ahk code
;; - to extract data from those leboncoin pages
;; - and put this data into an excel file

(defn between [str regstart regend]
  (let [thing-and-more (second
                          (clojure.string/split str regstart))]
  (if thing-and-more
    (first (clojure.string/split thing-and-more regend))
    nil)))

(defn first-of-split [str regex]
  (first
    (clojure.string/split str regex)))

(defn second-of-split [str regex]
  (second
    (clojure.string/split str regex)))

(defn between-2 [str regstart regend]
  (let [thing-and-more (second-of-split str regstart)]
    (if thing-and-more
      (first-of-split thing-and-more regend)
      nil)))

(defn extract-thing [regend str]
  (first (clojure.string/split str regend)))

; (partial extract-thing #"\"><")

(defn all-between [str regstart regend]
  (let [list (clojure.string/split str regstart)
        things-and-more (rest list)]
  (if things-and-more
    (let [thing-and-more (first things-and-more)
          ; thing (first (clojure.string/split thing-and-more regend))
          things (map (partial extract-thing regend) things-and-more)
          ]
      things)
    nil)))

(def current-dir "C:\\Users\\leocr\\Desktop\\leboncoin-scraping\\")

(defn slurp-here [filename]
  (slurp (str current-dir filename)))

; (slurp-here "04000.html")

(defn urls [search-page-filename]
  (all-between
    (slurp-here search-page-filename)
    #"class=\"sc-BngTV cODRLH\" href=\"" #"\"><"))


; (urls "03000.html")
; (first (urls "03000.html"))
; (first (urls "04000.html"))
; (first (urls "05000.html"))
; (second (urls "03000.html"))
; (second (urls "04000.html"))
; (second (urls "05000.html"))

; (flatten 
;   (conj (urls "03000.html") 
;         (urls "04000.html") 
;         (urls "05000.html")))


(defn inject-new-line [a b]
  (str a "\n" b))

(defn inject-new-lines [seq]
  (reduce inject-new-line seq))

(defn save-seq-into-txt-file [file-name seq]
  (spit file-name (inject-new-lines seq)))

(def all-urls
  (flatten 
    (conj (urls "03000.html") 
          (urls "04000.html") 
          (urls "05000.html"))))

; all-urls

; (save-seq-into-txt-file "urls.txt" all-urls)


