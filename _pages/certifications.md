---
title: Certifications
tags: [certifications, achievements]
permalink: /certifications
---
<div id="top"></div> <!-- Punto di ancoraggio per "Torna in cima" -->
<h1>Certifications</h1>

<p style="text-align: center; font-size: 16px; color: #555;">
    This page contains my personal certifications. Please note that reproduction or downloading of these certifications is strictly prohibited without permission.
    <br><br>
    Clicking on any of the certification boxes will open an external webpage. The <span style="color: red;">red</span> indicator means the link leads to an external website, while the <span style="color: blue;">blue</span> indicator shows the link leads to the certification saved in my Google Drive account.
</p>

<!-- Navigazione tra le sezioni -->
<nav>
    <ul>
        <li><a href="#top">Back to top</a></li>
        {% for category in site.data.certifications %}
            <li><a href="#{{ category.title | slugify }}">{{ category.title }}</a></li>
        {% endfor %}
        <li><a href="#bottom">Go to bottom</a></li>
    </ul>
</nav>


{% for category in site.data.certifications %}
<section id="{{ category.title | slugify }}">
    <h2 style="text-align: center;">{{ category.title }}</h2>
    <br>
    <div class="certifications-grid">
        {% for cert in category.items %}
        <div class="certification" data-pdf="{{ cert.pdf }}" data-link="{{ cert.link }}">
            <div class="cert-thumbnail">
                <img src="/assets/logos/{{ cert.logo | default: 'default-logo.png' }}" alt="{{ cert.name }} logo" class="cert-logo">
            </div>
            <p>{{ cert.name }}<br><small>{{ cert.date }}</small></p>
            <div class="indicator {% if cert.pdf and cert.link %}green{% elsif cert.pdf %}blue{% else %}red{% endif %}"></div>
        </div>
        {% endfor %}
    </div>
</section>
{% endfor %}
<div id="bottom"></div> <!-- Punto di ancoraggio per "Vai in fondo" -->

<!-- Pop-up scelta risorsa -->
<div id="resource-choice-popup">
    <p>Scegli come aprire la risorsa:</p>
    <button id="open-web">WEB</button>
    <button id="open-pdf">PDF</button>
    <button id="close-popup">Chiudi</button>
</div>

<!-- CSS -->
<style>
    /* Stile per la navigazione fissa a destra */
    nav ul {
        list-style: none;
        display: flex;
        flex-direction: column;
        gap: 15px;
        padding: 0;
        margin: 0;
        position: fixed;
        top: 50px; /* Posiziona il menu 50px sotto il top della pagina */
        right: 20px; /* Posiziona il menu a destra */
        z-index: 999;
        /* Rimosso il colore di sfondo, quindi utilizza il colore di default */
        border-radius: 10px;
        padding: 10px;
        width: 200px; /* Imposta la larghezza della barra laterale */
    }

    nav ul li {
        margin: 5px;
    }

    nav ul li a {
        text-decoration: none;
        color: #007bff;
        font-size: 16px;
        padding: 5px 10px;
        border-radius: 5px;
        transition: background-color 0.3s ease;
    }

    nav ul li a:hover {
        background-color: #007bff;
        color: white;
    }

    nav ul li a.active {
        background-color: #007bff;
        color: white;
    }

    /* Grid delle certificazioni */
    .certifications-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); gap: 20px; }
    .certification { text-align: center; padding: 10px; background: #eee; cursor: pointer; border-radius: 10px; position: relative; }
    .cert-thumbnail { display: flex; justify-content: center; align-items: center; height: 80px; }
    .cert-logo { max-width: 100px; max-height: 80px; }

    /* Indicatori */
    .indicator { position: absolute; bottom: 5px; right: 5px; width: 15px; height: 15px; border-radius: 50%; }
    .indicator.red { background: red; }
    .indicator.blue { background: blue; }
    .indicator.green { background: green; }

    /* Modal PDF */
    #resource-viewer {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.8);
        z-index: 1002;
        overflow: auto;
    }
    #resource-viewer button { position: absolute; top: 10px; right: 10px; font-size: 20px; background: red; color: white; border: none; padding: 10px; cursor: pointer; }

    /* Pop-up scelta */
    #resource-choice-popup {
        display: none;
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background: white;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        z-index: 1001;
        text-align: center;
    }
    #resource-choice-popup button {
        margin: 10px;
        padding: 10px 20px;
        cursor: pointer;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 5px;
    }
    #close-popup { background-color: red; color: white; }

    /* Disabilita Scroll */
    body.disable-scroll { overflow: hidden; }

    @media (max-width: 768px) {
        nav ul {
            flex-direction: column;
            right: 10px; /* Riduce la distanza dalla destra */
        }
        nav ul li {
            margin: 10px;
        }
    }

    /* Aggiunta di uno stile per i punti di ancoraggio */
    #top {
        padding-top: 50px;
        margin-top: -50px;
    }
    #bottom {
        padding-bottom: 50px;
        margin-bottom: -50px;
    }
</style>

<!-- JavaScript -->
<script>
    document.querySelectorAll('.certification').forEach(cert => {
        cert.addEventListener('click', function() {
            const pdfUrl = this.dataset.pdf;
            const linkUrl = this.dataset.link;

            if (pdfUrl && linkUrl) {
                document.getElementById('resource-choice-popup').style.display = 'block';
                document.body.classList.add('disable-scroll');
                document.getElementById('open-web').onclick = () => openExternalLink(linkUrl);
                document.getElementById('open-pdf').onclick = () => openPdf(pdfUrl);
            } else if (pdfUrl) {
                openPdf(pdfUrl);
                document.body.classList.add('disable-scroll');
            } else if (linkUrl) {
                openExternalLink(linkUrl);
                document.body.classList.add('disable-scroll');
            }
        });
    });

    document.querySelector('#close-popup').addEventListener('click', function() {
        document.getElementById('resource-choice-popup').style.display = 'none';
        document.body.classList.remove('disable-scroll');
    });

    function openPdf(url) {
        window.open(url, '_blank');
        document.getElementById('resource-choice-popup').style.display = 'none';
        document.body.classList.remove('disable-scroll');
    }

    function openExternalLink(url) {
        window.open(url, '_blank');
        document.getElementById('resource-choice-popup').style.display = 'none';
        document.body.classList.remove('disable-scroll');
    }

    // Aggiungere uno scorrimento fluido
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();

            document.querySelector(this.getAttribute('href')).scrollIntoView({
                behavior: 'smooth'
            });
        });
    });

    // Aggiungi osservatore per cambiare la classe attiva sui titoli
    const sections = document.querySelectorAll('section');
    const navLinks = document.querySelectorAll('nav ul li a');

    const observer = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const activeId = entry.target.id;
                navLinks.forEach(link => {
                    if (link.getAttribute('href') === `#${activeId}`) {
                        link.classList.add('active');
                    } else {
                        link.classList.remove('active');
                    }
                });
            }
        });
    }, { threshold: 0.5 }); // 50% della sezione deve essere visibile per essere considerata attiva

    sections.forEach(section => {
        observer.observe(section);
    });
</script>
