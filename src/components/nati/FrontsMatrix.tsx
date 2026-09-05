import { m } from 'motion/react'
import { Link } from 'react-router'
import { capabilities, matrix } from '@/content/nati'
import { groups } from '@/content/modulePages'
import { paths } from '@/content/site'
import { cn } from '@/lib/utils'
import { EASE, viewportOnce } from '@/lib/motion'

/**
 * A matriz de cobertura: sete frentes do RH por cinco capacidades da NATI.
 * As células acendem em onda ao entrar na tela. Tudo é texto de verdade, legível e lido por leitores de tela.
 */
export function FrontsMatrix({ tone = 'dark', className }: { tone?: 'dark' | 'light'; className?: string }) {
  const dark = tone === 'dark'
  return (
    <div className={cn('overflow-x-auto rounded-3xl border', dark ? 'border-white/12 bg-white/[0.04]' : 'border-brand-mist bg-white shadow-soft', className)}>
      <table className={cn('w-full min-w-[820px] border-collapse text-left', dark ? 'text-white' : 'text-brand-ink')}>
        <caption className="sr-only">O que a NATI faz em cada frente do RH: responde, analisa, alerta, executa e reporta</caption>
        <thead>
          <tr className={dark ? 'border-b border-white/10' : 'border-b border-brand-mist'}>
            <th scope="col" className={cn('px-4 py-3 text-[11px] font-semibold uppercase tracking-[0.14em]', dark ? 'text-white/55' : 'text-brand-graphite')}>
              Frente do RH
            </th>
            {capabilities.map((c) => (
              <th key={c.id} scope="col" className="px-3 py-3">
                <span className={cn('block text-[12px] font-extrabold uppercase tracking-[0.12em]', dark ? 'text-[#E4A9C4]' : 'text-brand-purple')}>{c.name}</span>
              </th>
            ))}
          </tr>
        </thead>
        <tbody>
          {groups.map((g, r) => (
            <tr key={g.id} className={dark ? 'border-b border-white/[0.06] last:border-0' : 'border-b border-brand-mist last:border-0'}>
              <th scope="row" className="px-4 py-2.5 align-middle">
                <Link to={`${paths.modules}#${g.id}`} className={cn('text-[13.5px] font-bold leading-snug hover:underline', dark ? 'text-white' : 'text-brand-ink')}>
                  {g.name}
                </Link>
              </th>
              {capabilities.map((c, k) => (
                <td key={c.id} className="px-2 py-1.5 align-middle">
                  <m.span
                    className={cn(
                      'block rounded-lg px-2.5 py-2 text-[12.5px] leading-snug',
                      dark ? 'text-white/85' : 'text-brand-graphite',
                    )}
                    initial={{ backgroundColor: dark ? 'rgba(255,255,255,0)' : 'rgba(81,28,118,0)', boxShadow: '0 0 0 0 rgba(201,87,136,0)' }}
                    whileInView={{
                      backgroundColor: dark ? 'rgba(255,255,255,0.07)' : 'rgba(81,28,118,0.06)',
                      boxShadow: ['0 0 0 0 rgba(201,87,136,0)', '0 0 0 2px rgba(201,87,136,0.55)', '0 0 0 0 rgba(201,87,136,0)'],
                    }}
                    viewport={viewportOnce}
                    transition={{ duration: 0.9, ease: EASE, delay: 0.15 + (r * capabilities.length + k) * 0.045 }}
                  >
                    {matrix[g.id][c.id]}
                  </m.span>
                </td>
              ))}
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  )
}
