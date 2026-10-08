# Ilustrações dos módulos — especificação de estilo (28/09/2026)

Sem imagem de referência (Gamma não aceita referência de ESTILO, só de "sujeito"), o estilo
inteiro tem que ir por escrito. Cada pedido = BLOCO DE ESTILO (igual em todos, colado
verbatim) + CENA do módulo + RESTRIÇÕES (iguais em todos).

Medido na `referencia/docs_cad.png` (e confirmado nas três já geradas):

| O quê | Como é na original |
|---|---|
| Gênero | ilustração vetorial corporativa isométrica plana ("flat isometric"), família das bibliotecas de ilustração SaaS |
| Projeção | isométrica verdadeira, eixos a 30°, sem perspectiva, sem ponto de fuga |
| Traço | NENHUM contorno; formas definidas só por preenchimento |
| Sombreado | 1 degrau por face: topo claro, face esquerda média, face direita escura; sem degradê, sem textura, sem granulado, sem brilho |
| Pessoas | alongadas (~8 cabeças), cabeça pequena SEM rosto (sem olhos, boca, nariz), cabelo em bloco de cor única, mãos em forma simples, calça reta, sapato em bloco |
| Pele | pêssego #F0C0A8 / #FCC0A8 e um tom marrom #845460; variados |
| Sombra no chão | losango isométrico chapado #E4F0F0 sob cada objeto e pessoa |
| Elementos de interface | cartões flutuantes arredondados em lilás pálido com linhas finas (1 px) azul-claro, avatar redondo, gráfico de linha em rosa |
| Paleta (% da área) | #E4F0F0 16 · #544884 13 · #9CB4D8 11 · #242460 9 · #48246C 8 · #784890 7 · #D884B4 7 · #C05484 5 · #D8E4F0 4 |
| Composição | 4–5 pessoas em volta de 1 objeto-conceito GRANDE; espaço vazio generoso; nada cortado |
| Balão | um balão de fala rosa com três pontos brancos, flutuando no alto |

## BLOCO DE ESTILO (verbatim)

```
ART STYLE — corporate flat isometric vector illustration, the kind used in modern SaaS / HR software onboarding screens. Pure vector look, as if exported from Adobe Illustrator: crisp geometric shapes, perfectly flat color fills, NO outlines or strokes on any shape, NO gradients, NO texture, NO grain, NO noise, NO glow, NO 3D render, NO photorealism, NO painterly or hand-drawn marks.

PROJECTION — true isometric projection, all receding edges at exactly 30 degrees, no perspective, no vanishing point, camera seen from above at the classic isometric angle. Every object sits on the same invisible isometric floor plane.

SHADING — exactly one tone step per face of every object: top face lightest, left face medium, right face darkest (light comes from the upper left). Flat, hard-edged shading only. Under every object and every person, a flat pale ground shadow shaped as an isometric rhombus or ellipse in #E4F0F0, hard edged.

PEOPLE — slender, elongated adult office workers, about 8 heads tall, standing or working naturally. Small simple heads with NO facial features at all (no eyes, no mouth, no nose, no eyebrows): the face is a plain skin-colored shape. Hair drawn as one solid block of color, simple modern cuts (short side-parted, long straight, ponytail, bun, short beard). Hands are simple rounded shapes. Clothes are flat blocks with at most one darker fold: blazers and sweaters in deep navy or purple, tops in pink or light periwinkle, straight trousers in dark navy or light blue, simple block shoes. Varied skin tones (peach #F0C0A8, light #FCC0A8, brown #845460) and genders. Calm, professional body language, collaborative.

OBJECTS — large, simple, readable isometric objects built from boxes, slabs and rounded rectangles. Floating interface cards: rounded rectangles in pale lilac #E9E5F1 or #D8E4F0 with thin 1-pixel light blue #9CB4D8 lines as abstract text, a round avatar icon, small bar or line charts in pink. No real screens content, no readable UI.

PALETTE — use ONLY these colors, in roughly these proportions: pale ground/light surfaces #E4F0F0 and #D8E4F0 and #E9E5F1 and white (about 30%); slate purple #544884 (13%); periwinkle blue #9CB4D8 (11%); deep navy #242460 / #2C1A63 (10%); purple #48246C / #511C76 (8%); plum #784890 / #9A408A (7%); soft pink #D884B4 (7%); raspberry pink #C05484 / #C95788 (5%); plus the skin tones. NO green, NO yellow, NO orange, NO red, NO black, NO cyan, NO brown objects.

COMPOSITION — square canvas, one hero object in the center, four or five people arranged around it doing distinct tasks, secondary props and two or three floating interface cards around them. One pink speech bubble with three white dots floating near the top. Generous empty margin on all sides (the whole scene occupies about 75% of the canvas), nothing cropped by the edge. Solid pure white background #FFFFFF, no floor color, no scenery, no walls, no sky.
```

## RESTRIÇÕES (verbatim, no fim)

```
STRICT — no text, no letters, no numbers, no words, no logos, no brand marks, no flags, no national symbols, no watermark, no signature, no border or frame. Faceless people. Flat vector only. Pure white background.
```

## CENAS (uma por módulo)

**inf-cadastrais — Informações Cadastrais e Funcionais**
```
SCENE — the hero object is a giant isometric employee record card standing upright like a panel, with a large round avatar at the top, a small rectangular photo slot, and rows of thin abstract lines. Around it: a woman in a pink top placing a smaller ID document card into the panel; a man in a navy sweater holding a tablet and checking the data; a woman seated on a stack of blue folders typing on a laptop; a man with a beard carrying a big blue folder. Floating cards: a small ID card with an avatar, a card with a check mark in a pink circle, a card with three stacked lines.
```

**folha — Folha de Pagamento**
```
SCENE — the hero object is a large isometric payslip sheet lying on the floor like a platform, with abstract rows and a highlighted pink total bar, next to a big isometric desk calculator with square keys in purple and periwinkle. Around it: a woman in a pink top pressing keys on the calculator; a man in a navy blazer walking with a stack of coins; a man with a beard sitting on a stack of coins using a laptop; a woman holding a clipboard. Props: three stacks of coins in plum and pink, a floating bar chart card with rising pink bars, a floating card with a wallet icon.
```

**beneficios — Benefícios dos Funcionários**
```
SCENE — the hero object is a large isometric gift box in purple with a pink ribbon, lid lifted, with benefit cards rising out of it: a card with a heart, a card with a medical cross, a card with a shopping basket, a card with a small bus. Around it: a woman in a periwinkle top holding a heart-shaped card; a man in a navy sweater holding a large benefit card like a credit card; a woman with a bun pushing a small shopping cart; a man with a beard carrying a lunch box. A floating card with a round avatar and a check mark.
```

**frequencia — Controle de Frequência**
```
SCENE — the hero object is a large isometric wall clock standing on the floor as a thick cylinder in purple, with a white face and pink hands (no numbers, only small tick marks), next to a tall time-clock terminal kiosk with a blank screen. Around it: a woman in a pink top holding an ID badge up to the kiosk; a man in a navy blazer checking his wristwatch; a man with a beard seated at a small desk with a laptop showing a calendar grid; a woman walking in holding a coffee cup. Floating cards: a monthly calendar grid with a few squares highlighted in pink, a card with an hourglass.
```

**politicas — Políticas**
```
SCENE — the hero object is a big open isometric rulebook standing upright, pages in white with abstract lines, cover in purple, next to a large balance scale in plum with two pans in balance. Around it: a woman in a pink top pointing at a page of the book; a man in a navy sweater reading a document; a woman with a ponytail placing a small document on one pan of the scale; a man with a beard holding a shield with a check mark. Floating cards: a document with a check mark, a card with three bullet lines.
```

**natpay — NatPay**
```
SCENE — the hero object is a giant isometric smartphone lying at an angle like a platform, its screen showing an abstract payment confirmation: a large pink circle with a white check mark and two thin lines. Around it: a woman in a pink top tapping a contactless card on the phone; a man in a navy blazer sending coins that fly in an arc from one small phone in his hand toward the big phone; a man with a beard holding a wallet; a woman seated on a coin stack using a tablet. Floating cards: a bank card in purple and plum, a card with two curved arrows forming a loop (instant transfer), a card with a coin.
```

**cargos-salarios — Cargos e Salários**
```
SCENE — the hero object is a large isometric staircase of five blocks rising from left to right, each step a slightly darker shade from periwinkle to deep navy, with a trophy in pink on the top step. Around it: a man in a navy blazer climbing the steps; a woman in a pink top standing on a higher step holding a flag-free pennant card with a star; a woman with a bun below holding a clipboard with a salary range bar (three horizontal bars of different lengths); a man with a beard placing a coin stack beside the stairs. Floating cards: a card with a rising line chart, a card with a small ladder icon.
```

**recrutamento — Recrutamento e Seleção**
```
SCENE — the hero object is a huge isometric magnifying glass in purple with a pink handle, hovering over a fan of three large résumé cards with avatars and abstract lines. Around it: a woman in a pink top holding the magnifying glass handle; a man in a navy sweater and a woman seated face to face at a small interview table with a laptop between them; a candidate in a periwinkle shirt walking in holding a folder. Floating cards: an avatar card with a check mark, an avatar card with a star, a small calendar card.
```

**treinamento — Treinamento**
```
SCENE — the hero object is a large isometric presentation screen on a stand showing an abstract slide with a pink bar chart and a play triangle, beside a stack of books and a graduation cap in deep navy with a pink tassel. Around it: a woman in a pink top presenting and pointing at the screen; three people seated on simple stools facing the screen, one with a laptop, one with a notebook, one raising a hand; a rolled certificate with a pink ribbon on the floor. Floating cards: a certificate card with a medal, a card with a light bulb.
```

**avaliacoes — Avaliações**
```
SCENE — the hero object is a large isometric evaluation form standing upright, with rows of five stars, some filled in pink and some empty, and check boxes. Around it: a woman in a pink top filling a star with a big pencil; a man in a navy blazer and a woman in a periwinkle top sitting at a small round table in a one-on-one feedback conversation; a man with a beard holding a target board with an arrow in the center. Floating cards: a speech card with a thumbs-up, a card with a rising line chart, a card with a small flag-free goal target.
```

**medicina — Medicina Ocupacional**
```
SCENE — the hero object is a large isometric medical clipboard standing upright with a pink medical cross at the top and abstract lines (the occupational health record), beside a big stethoscope in deep navy lying across the floor. Around it: a doctor in a white coat over a purple top listening to a patient's chest with a stethoscope; the patient, a man in a periwinkle shirt, sitting on an examination stool; a nurse in a pink top holding a tablet; a woman with a bun carrying a first-aid kit in plum with a white cross. Floating cards: a heart with a pulse line, a card with a check mark, a small calendar card.
```

**seguranca — Segurança do Trabalho**
```
SCENE — the hero object is a giant isometric safety helmet in pink resting on a platform, beside two traffic cones striped in plum and white and a short barrier. Around it: a worker in a high-visibility vest drawn in periwinkle with white stripes, wearing a navy helmet and holding a checklist clipboard; a woman in a pink helmet and gloves inspecting a fire extinguisher in plum; a man in a navy blazer pointing at a warning sign with a simple exclamation mark in a triangle (no text); a woman holding a pair of safety goggles. Floating cards: a shield with a check mark, a card with a helmet icon.
```

**juridico — Jurídico**
```
SCENE — the hero object is a large isometric balance of justice in deep navy and plum, two pans, standing on a thick block pedestal, next to a big judge's gavel lying on a sound block. Around it: a lawyer woman in a navy blazer holding a thick case folder; a man in a purple suit reading a document; a woman in a pink top stacking case folders; a man with a beard seated at a desk with a laptop. Floating cards: a document with a seal, a folder with a paper clip, a card with a check mark.
```

**acessos — Acessos**
```
SCENE — the hero object is a giant isometric padlock in purple with a pink keyhole, its shackle open, standing on a platform, beside a big key in plum. Around it: a woman in a pink top turning the key in the lock; a man in a navy sweater at a laptop managing user profiles; a woman with a ponytail holding a large ID card with an avatar up to a card reader; a man with a beard holding a shield with a check mark. Floating cards: three small user-profile cards with avatars connected by thin lines, a card with a password field shown as dots, a card with a toggle switch.
```

**termos — Termos**
```
SCENE — the hero object is a large isometric document sheet standing upright with abstract lines and a signature line at the bottom with a flowing pink scribble signature (not letters), a big fountain pen in deep navy beside it, and a round approval seal in pink with a white check mark. Around it: a woman in a pink top signing the document with the pen; a man in a navy blazer holding a stamp; a man with a beard reading a document on a tablet; a woman giving a thumbs-up. Floating cards: a check box card with a check mark, a card with a handshake icon.
```

**esocial — eSocial**
```
SCENE — the hero object is a large isometric cloud in pale lilac floating at the upper right, with a big shield in slate purple on it and a white check mark on the shield (secure government transmission, but NO flag, NO coat of arms, NO national colors). A stream of small isometric document blocks in pink, periwinkle and white rises in a diagonal line from a giant open laptop on the floor up to the cloud. Around it: a man in a navy sweater typing on the giant laptop, whose screen shows an abstract form; a woman in a pink top walking toward the stream carrying a document; a woman seated on a tall stack of paper sheets using a tablet; a man with a beard pointing at a big standing monthly calendar grid with one day highlighted in pink (deadlines). Floating cards: a small bar chart with a pink check badge.
```

**adm-pessoal — Administração de Pessoal**
```
SCENE — the hero object is a large isometric filing cabinet in deep navy with one drawer pulled open, full of employee folders in pink, plum and periwinkle. Behind it, a big standing board shows a simple org chart of round avatar circles joined by thin lines. Around it: a man in a navy blazer sorting folders in the open drawer; a woman in a pink top pointing at the org chart; a man with a beard working at a desk on a monitor that shows an employee profile card (round avatar and abstract lines), sitting on a pink office chair; a woman in a periwinkle top carrying a box of folders. Floating cards: a bar chart with pink and purple bars.
```

**movimentacoes — Movimentações Funcionais**
```
SCENE — two isometric office desk platforms, one lower on the left and one higher on the right, joined by a big curved arrow in pink rising from the old desk to the new one (job movement: transfer, promotion, change of role). A woman in a pink top walks along the arrow carrying a small box of belongings with a plant in it; a man in a navy blazer works at the old desk; a woman at the new pink desk welcomes her with an open hand; a man in a navy sweater climbs a set of three purple isometric steps; a man with a beard holds a clipboard with a checklist. Floating cards: a tall employee badge card with a round avatar and a pink circle with a white up arrow.
```

Arquivos: `ilustra-<modulo>.png`. Pós: `python3 limpar.py geradas/<modulo>-v1.png ilustra-<modulo>.png`
(o fundo branco puro entra no mesmo critério do cinza neutro e sai a partir da borda).
