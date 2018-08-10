package main

import (
	"flag"
	"fmt"
	"log"
	"net/http"
	"os"
	"text/template"
	"time"
)

const (
	port = 80
)

var (
	indexTmpl *template.Template
	greeting  *string = flag.String("greeting", "Hello", "Word(s) with which to greet browsers")
)

func init() {
	indexTmpl = template.Must(template.ParseFiles("index.template"))
}

func main() {
	flag.Parse()
	http.HandleFunc("/", indexHandler)
	http.HandleFunc("/logo.png", logoHandler)
	log.Printf("Listening on port %d", port)
	server := &http.Server{Addr: fmt.Sprintf(":%d", port)}
	server.SetKeepAlivesEnabled(false)
	log.Fatal(server.ListenAndServe())
}

func logoHandler(w http.ResponseWriter, r *http.Request) {
	http.ServeFile(w, r, "logo.png")
}

type TemplateArgs struct {
	Greeting string
	Host     string
	Time     string
}

func indexHandler(w http.ResponseWriter, r *http.Request) {
	hostname, err := os.Hostname()
	if err != nil {
		http.Error(w, "Can't get hostname", 500)
	}
	indexTmpl.Execute(w, TemplateArgs{
		Greeting: *greeting,
		Host:     hostname,
		Time:     time.Now().Format("15:04:05"),
	})
}
