import { useEffect, useState } from 'react'
import { Link } from 'react-router'
import { AnimatePresence, m } from 'motion/react'
import { Cookie } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { consentimentoAtual, EVENTO, registrarConsentimento } from '@/lib/consent'
import { paths } from '@/content/site'
import { EASE } from '@/lib/motion'

/**
 * Barra de consentimento de cookies.
 *
 * Duas decisões que a LGPD cobra e que são fáceis de errar:
 *
 * 1. **Recusar é tão fácil quanto aceitar.** Os dois botões têm o mesmo peso e
 *    o mesmo número de cliques. Um "Aceitar" grande com um "preferências"
 *    escondido em link é consentimento induzido — e induzido não é válido.
 * 2. **Não bloqueia a página.** Não é modal, não tem véu: a pessoa pode ler o
 *    site sem responder. Enquanto não responde, nada é carregado.
 *
 * A barra só aparece quando ainda não há resposta. Depois, o rodapé oferece
 * "Cookies" para reabrir.
 */
export function CookieBar() {
  /* Lê o estado na inicialização, não num efeito: o site é SPA sem SSR, então
     localStorage já existe no primeiro render. Ler no efeito faria a barra
     aparecer e sumir num piscar para quem já tinha respondido. */
  const [aberta, setAberta] = useState(() => consentimentoAtual() === null)

  useEffect(() => {
    // o efeito só assina o evento — quem muda o estado é a escolha da pessoa
    const aoMudar = (e: Event) => setAberta((e as CustomEvent).detail === null)
    window.addEventListener(EVENTO, aoMudar)
    return () => window.removeEventListener(EVENTO, aoMudar)
  }, [])

  const responder = (valor: 'aceito' | 'recusado') => {
    registrarConsentimento(valor)
    setAberta(false)
  }

  return (
    <AnimatePresence>
      {aberta && (
        <m.aside
          initial={{ y: '110%' }}
          animate={{ y: 0 }}
          exit={{ y: '110%' }}
          transition={{ duration: 0.45, ease: EASE }}
          /* z-index abaixo do menu aberto e acima dos botões flutuantes.
             `pb-[env(safe-area-inset-bottom)]` mantém os botões acima da barra
             de gestos do iPhone. */
          className="fixed inset-x-0 bottom-0 z-[45] border-t border-brand-mist bg-white/95 pb-[env(safe-area-inset-bottom)] shadow-[0_-8px_32px_-16px_rgba(27,18,56,.35)] backdrop-blur-md"
          role="region"
          aria-label="Aviso de cookies"
        >
          <div className="container flex flex-col gap-4 py-4 sm:flex-row sm:items-center sm:gap-6">
            <span className="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-brand-off-white text-brand-purple">
              <Cookie className="h-5 w-5" strokeWidth={1.8} aria-hidden />
            </span>

            <p className="flex-1 text-[13.5px] leading-relaxed text-brand-graphite">
              Usamos cookies para entender como o site é usado e melhorar a experiência. Os de medição e marketing só
              são ativados se você aceitar.{' '}
              <Link to={paths.privacy} className="font-semibold text-brand-purple underline-offset-2 hover:underline">
                Como tratamos seus dados
              </Link>
              .
            </p>

            <div className="flex shrink-0 gap-2">
              <Button variant="secondary" onClick={() => responder('recusado')} className="flex-1 sm:flex-none">
                Recusar
              </Button>
              <Button onClick={() => responder('aceito')} className="flex-1 sm:flex-none">
                Aceitar
              </Button>
            </div>
          </div>
        </m.aside>
      )}
    </AnimatePresence>
  )
}
