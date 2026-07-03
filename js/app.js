function archivarOT(otId) {
  var ot = allReportes.find(function(x){ return x.id === otId; });
  if (!ot) { showMsg('err-msg','err','No se encontro la OT.'); return; }
  if (!otsArchivadas.some(function(x){ return x.id === otId; })) {
    otsArchivadas.unshift(ot);
  }
  if (document.getElementById('pane-ot').classList.contains('on')) loadOTsArchivadas();
  showMsg('ok-msg','ok','OT archivada correctamente.');
  document.getElementById('ot-area').innerHTML = '';
}