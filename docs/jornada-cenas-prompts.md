# Cenas ilustradas da Jornada (história da Ana)

As cenas entram na página `/jornada-da-contratacao` por arquivo, sem mudar código:
`src/assets/journey/scene-<id-da-etapa>.jpg` (16:9, 1920x1080, JPG qualidade 82).
As legendas de acessibilidade estão em `src/content/journeyArt.ts` (`sceneCaptions`).

Estilo comum: mesmo 3D animado dos bonecos em `src/assets/journey/figure-*.png` (Pixar-like, pele suave,
olhos grandes), indústria de alimentos Vale Verde Alimentos, unidade de Sorocaba, paleta da interface em
roxo `#511C76` e rosa `#C95788`, telas só com blocos abstratos (nenhum texto legível), luz limpa, leve
profundidade de campo. Cada prompt usa os bonecos como referência de identidade e um canvas 16:9 em branco
como última referência, para travar a proporção paisagem.

Fluxo no ElevenLabs com as referências já carregadas: https://elevenlabs.io/app/flows/UBy8QSFHWHl0VpX7esvi
Custo por cena com referência (set/2026): gemini-3-pro-image 1.827 créditos; gemini-3.1-flash-image 609;
gpt-image-2 420. Recomendação: gemini-3.1-flash-image (segura a identidade dos personagens a um custo
intermediário). O plano gratuito libera uma imagem por dia.

Bloco comum no início de cada prompt:

> Using the attached references: the character references provide exact identity (face, hair, glasses,
> outfit) and the rendering style; the blank 16:9 canvas provides only the output size and aspect ratio
> (1920x1080 landscape). Do not adopt the portrait ratio of the character references. Style: polished 3D
> animated film still, same rendering as the reference characters, shallow depth of field, clean bright
> lighting with subtle purple (#511C76) and pink (#C95788) accents from the app UI. Screens and floating UI
> cards show only abstract rounded blocks and icons, no readable text.

## etapa-01 · Marcos abre a requisição de vaga (ref.: Marcos)
Wide 16:9, medium shot, eye level: Marcos (white lab coat over a dark purple polo, black trousers, safety
boots) stands on the floor of a modern food-processing plant: stainless steel line, conveyor with packaged
food, workers in white coats and hairnets softly blurred behind, a brand-new production line being
installed on the right. He holds a smartphone in one hand, smiling with confidence while tapping it. Next
to the phone floats a translucent UI card with abstract form fields and a bright pink check mark.

## etapa-04 · Ana se candidata do sofá (ref.: Ana)
Wide 16:9, cozy living room at night: Ana (dark hair in a low bun, round glasses, purple blouse, dark
trousers, white sneakers) sits relaxed on a light sofa with her legs tucked under her, holding the phone
with both hands and smiling. Warm floor lamp, a plant, a closed laptop and a mug on the side table. A soft
floating UI card near the phone shows abstract profile fields and a pink send button.

## etapa-10 · Beatriz confere a admissão (ref.: Beatriz)
Wide 16:9: Beatriz (black ponytail, purple blazer over a white top, black skirt) at her desk in a bright
HR office, focused and pleased, one hand on the trackpad of a notebook whose screen shows a two-panel
review: a document thumbnail on one side and abstract fields with green check marks on the other. Glass
wall behind her with the plant floor softly visible, coffee cup, small plant.

## etapa-11 · Dr. Henrique registra o exame admissional (ref.: Henrique, Ana)
Wide 16:9, occupational health room inside the plant: Dr. Henrique (grey hair, white coat, stethoscope,
blue shirt) sits at his desk registering the exam on a tablet, calm and attentive. Ana sits across from
him, relaxed, badge on a lanyard. Examination bed, blood-pressure cuff and a wall monitor with an abstract
form and a green check in the background.

## etapa-13 · Beatriz confirma a admissão com um clique (ref.: Beatriz)
Wide 16:9, medium close-up: Beatriz at her desk, finger pressing the trackpad, joyful. The notebook screen
shows a large glowing purple confirm button, and from the screen radiates a soft burst of connected icons
on thin lines (a payroll sheet, a clock, a heart for benefits, a government building, a phone), meaning
that everything updates at once. Office background softly blurred.

## etapa-16 · Ana marca o ponto na portaria com o NatPonto (ref.: Ana)
Wide 16:9, morning light: Ana at the plant entrance lobby, glass doors and a turnstile behind her, badge
on a lanyard, holding her phone at face level. The phone screen shows a face-scan frame with soft purple
corner brackets and a green check. A security guard at the desk in the background, softly blurred.

## etapa-17 · Rafael entrega os EPIs e Ana assina a ficha (ref.: Rafael, Ana)
Wide 16:9, safety storeroom: Rafael (orange high-visibility vest over a navy shirt, khaki trousers) behind
a counter, handing over a white hard hat, safety goggles and gloves, smiling. Ana on the other side signs
on a tablet with her finger. Shelves of PPE (helmets, gloves, ear protectors) behind them.

## etapa-18 · Ana na trilha de treinamento do cargo (ref.: Ana)
Wide 16:9, bright training room: Ana seated at a table in the front row with three other new hires
(generic, diverse, in company polo shirts), attentive, badge on a lanyard. An instructor stands by a large
screen showing an abstract safety slide with icons only. Windows with the plant visible outside.

## etapa-23 · O RH fecha a folha com a NATI (ref.: Paulo, NATI)
Wide 16:9, open-plan HR office: Paulo (short curly hair, glasses, lilac shirt) at a notebook, relaxed and
satisfied, two colleagues at other desks with notebooks, softly blurred. A large wall monitor shows an
abstract dashboard with purple bars and a progress bar almost complete. Beside Paulo's screen floats a
small glowing presence of NATI (the avatar reference: purple hair, headset), like a friendly holographic
assistant.

## etapa-24 · Um ano depois, Ana promovida, com a equipe (ref.: Ana, Marcos)
Wide 16:9, plant floor: Ana one year later, same face and glasses, now with a light grey blazer over the
purple blouse, badge on a lanyard, standing confident at the center. Marcos beside her with a hand on her
shoulder, proud. Behind them a small team of four workers in white coats and hairnets applauding and
smiling. Bright daylight, stainless steel line softly blurred.
