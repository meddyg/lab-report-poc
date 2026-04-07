(function() {
     var cb = new ClipboardJS('.fsr-copy-btn');
     cb.on('success', function(e) {
       var btn = e.trigger;
       btn.textContent = '\u2713 Copiado';
       setTimeout(function() { btn.textContent = 'Copiar'; }, 1800);
       e.clearSelection();
     });
   })();