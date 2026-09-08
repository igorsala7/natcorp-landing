import { Link } from 'react-router'
import { ArrowRight } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Reveal } from '@/components/motion/Reveal'
import { paths } from '@/content/site'

/**
 * Faixa de conversão no MEIO da página.
 *
 * Existe porque o CTA grande fica só no fim: numa página de 17 seções, quem se
 * convence na quinta precisa rolar doze para agir — e a maioria não rola. Esta
 * faixa é o atalho, e por isso é deliberadamente pequena: uma linha, um botão,
 * sem formulário. O formulário continua sendo o do fim; aqui a pessoa só diz
 * "quero falar" e é levada até ele.
 *
 * Não repetir mais de uma vez na mesma página: duas faixas iguais deixam de ser
 * atalho e viram ruído.
 */
export function CTAInline({
  titulo = 'Quer ver isso com os dados da sua empresa?',
  acao = 'Agendar demonstração',
  tom = 'claro',
}: {
  titulo?: string
  acao?: string
  /** `claro` para seções brancas; `marca` quando precisa separar dois blocos claros. */
  tom?: 'claro' | 'marca'
}) {
  const naMarca = tom === 'marca'
  return (
    <section className={naMarca ? 'bg-white py-8 sm:py-10' : 'bg-brand-off-white py-8 sm:py-10'}>
      <div className="container">
        <Reveal>
          <div
            className={
              naMarca
                ? 'flex flex-col items-start gap-5 rounded-2xl bg-[linear-gradient(120deg,#2C1A63,#511C76_55%,#9A408A)] p-6 text-white sm:flex-row sm:items-center sm:justify-between sm:p-8'
                : 'flex flex-col items-start gap-5 rounded-2xl border border-brand-mist bg-white p-6 sm:flex-row sm:items-center sm:justify-between sm:p-8'
            }
          >
            <p
              className={
                naMarca
                  ? 'text-[19px] font-extrabold leading-snug tracking-brand sm:text-[21px]'
                  : 'text-[19px] font-extrabold leading-snug tracking-brand text-brand-ink sm:text-[21px]'
              }
            >
              {titulo}
            </p>
            <Button asChild size="lg" variant={naMarca ? 'inverse' : 'default'} className="shrink-0">
              <Link to={`${paths.home}#contato`}>
                {acao}
                <ArrowRight aria-hidden />
              </Link>
            </Button>
          </div>
        </Reveal>
      </div>
    </section>
  )
}
