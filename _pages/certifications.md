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
<!-- Navigation Menu -->
<nav id="menu">
    <ul>
        <li><a href="#" data-category="all" class="active">ALL</a></li>
        {% for category in site.data.certifications %}
        <li><a href="#" data-category="{{ category.title | slugify }}">{{ category.title }}</a></li>
        {% endfor %}
    </ul>
</nav>
<div id="certifications-container">
    {% for category in site.data.certifications %}
    <section class="certification-category" data-category="{{ category.title | slugify }}">
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
</div>

<!-- Pop-up scelta risorsa -->
<div id="resource-choice-popup">
    <p>Scegli come aprire la risorsa:</p>
    <button id="open-web">WEB</button>
    <button id="open-pdf">PDF</button>
    <button id="close-popup">Chiudi</button>
</div>

<!-- CSS -->
<style>
    /* Navigation Menu */
    #menu {
        background: #333;
        padding: 10px 0;
        text-align: center;
    }
    #menu ul {
        list-style: none;
        padding: 0;
        margin: 0;
        display: flex;
        justify-content: center;
        flex-wrap: wrap;
    }
    #menu li {
        margin: 10px 15px;
    }
    #menu a {
        color: white;
        text-decoration: none;
        font-size: 16px;
    }
    #menu a:hover, #menu a.active {
        text-decoration: underline;
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

    /* Nascondi tutte le categorie di certificazioni per default */
    .certification-category {
        display: none;
    }

    /* Mostra tutte le certificazioni quando la categoria è "all" */
    .certification-category[data-category="all"] {
        display: block;
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

    // Funzione per filtrare le certificazioni
    document.querySelectorAll('#menu a').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();
            const category = this.getAttribute('data-category');
            document.querySelectorAll('.certification-category').forEach(section => {
                if (category === 'all' || section.getAttribute('data-category') === category) {
                    section.style.display = 'block';
                } else {
                    section.style.display = 'none';
                }
            });
            // Rimuovi la classe "active" da tutte le voci del menu
            document.querySelectorAll('#menu a').forEach(a => a.classList.remove('active'));
            // Aggiungi la classe "active" alla voce del menu cliccata
            this.classList.add('active');
        });
    });

    // Imposta la voce "ALL" come selezionata di default
    document.querySelector('[data-category="all"]').click();
</script>
