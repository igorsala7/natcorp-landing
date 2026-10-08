/* sb-timeline.js — versão Natcorp (plugin "Timeline" da região Linha do Tempo).
   Substitui o arquivo js/sb-timeline.js do plugin (Shared Components › Plug-ins › Timeline ›
   Files). Três mudanças em relação ao original, marcadas com "Natcorp:":
   1. ALTURA: a região tinha altura fixa (700 px) e a faixa dos fatos, com muitos fatos, ocupava
      664 — a descrição do item clicado ficava com 36 px, invisível. Agora, depois de montar,
      a região cresce para "faixa dos fatos + ALTURA_DESCRICAO" e a descrição aparece.
   2. FILTRAR (apexrefresh) ficou leve: o original removia os eventos UM A UM e adicionava os
      novos UM A UM — com 1.500 fatos, 3.000 redesenhos seguidos, que travavam o navegador.
      Agora a linha do tempo é recriada de uma vez com os dados novos.
   3. Sem mudança de comportamento no resto (sem dados, idioma, posição da faixa). */
(function($){
   'use strict';
   var ndfDateID = 'sb-ndf-date';
   var ndfDate = {unique_id:ndfDateID,text:{headline:'No Data Found'},start_date:{ year: new Date().getFullYear()}} ;
   var ALTURA_DESCRICAO = 320;   // Natcorp: espaço da descrição abaixo do gráfico
   var timeline$;
   var ndf$;
   var timeline;
   var isEmpty = false;
   var o;

   $.widget("sb.timeline", {
      options: {
         timelineID: null,
         ndfID: null,
         timenav_position: null,
         language : 'en',
         layout: 'landscape',
         width: null,
         height: null,
         ajaxIdentifier: null,
         pageItems:null
      },
      _create: function() {
         var that = this;
         o = that.options;
         timeline$ = $('#'+o.timelineID);
         ndf$ = $('#'+o.ndfID);

         this._getData().done(function(tlData){
            that._montar(tlData);
         });

         this.element.on('apexrefresh', function( event ){
            that._refresh();
         });
      },
      _getData: function(){
         return apex.server.plugin(
            this.options.ajaxIdentifier,
            {
               x10: "DATA",
               pageItems: this.options.pageItems
            }
         );
      },
      // Natcorp: monta (ou remonta) a linha do tempo inteira de uma vez
      _montar: function(tlData){
         if(!tlData || !tlData.events || tlData.events.length === 0){
            tlData = tlData || {};
            tlData.events = [$.extend(true,{},ndfDate)];
            isEmpty = true;
         }else{
            isEmpty = false;
         }
         timeline$.empty();
         timeline = new TL.Timeline(o.timelineID,tlData, {
            timenav_position : o.timenav_position,
            language: o.language,
            layout: o.layout,
            width: o.width,
            height: o.height
         });
         this._updateDisplay();
         this._ajustarAltura();
      },
      // Natcorp: a região = faixa dos fatos + espaço da descrição (mede depois de desenhar)
      _ajustarAltura: function(){
         var tentativas = 0;
         var ajustar = function(){
            if(!timeline || isEmpty){ return; }
            var nav = timeline$.find('.tl-timenav').outerHeight() || 0;
            if(!nav){
               if(++tentativas < 20){ setTimeout(ajustar, 100); }
               return;
            }
            var alvo = Math.round(nav + ALTURA_DESCRICAO);
            timeline$[0].style.setProperty('--nc-tl-detalhe', ALTURA_DESCRICAO + 'px');
            if(Math.abs(timeline$.outerHeight() - alvo) > 2){
               timeline$.css('height', alvo + 'px');
               // o TimelineJS guarda a altura da montagem em options.height: atualiza e redesenha
               if(timeline.options){ timeline.options.height = alvo; }
               // logo depois de montar, o componente ainda ignora o "resize": repete o sinal
               // nos primeiros instantes até ele redistribuir as faixas
               [0, 300, 900, 1800].forEach(function(ms){
                  setTimeout(function(){ window.dispatchEvent(new Event('resize')); }, ms);
               });
               // a faixa dos fatos pode mudar de altura depois do novo desenho: confere de novo
               if(++tentativas < 3){ setTimeout(ajustar, 150); }
            }
         };
         setTimeout(ajustar, 0);
      },
      _refresh : function(){
         var that = this;
         this._getData().done(function(tlData){
            if(tlData && tlData.hasOwnProperty('events')){
               if(tlData.events.length === 0){
                  that._noDataFound();
                  return;
               }
               that._montar(tlData);   // Natcorp: recria de uma vez (antes: remove/adiciona um a um)
            }
         });
      },
      _noDataFound : function(){
         isEmpty = true;
         this._updateDisplay();
      },
      _updateDisplay : function(){
         if(isEmpty){
            timeline$.hide();
            ndf$.show();
         }else{
            timeline$.show();
            ndf$.hide();
         }
      }
   });
})(apex.jQuery);
