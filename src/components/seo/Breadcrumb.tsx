import { ChevronRight } from 'lucide-react'
import { Link } from 'react-router'
import { JsonLd } from './JsonLd'
import { siteConfig } from '@/content/site'
import { cn } from '@/lib/utils'

export interface Crumb {
  label: string
  to?: string
}

export function Breadcrumb({ items, className }: { items: Crumb[]; className?: string }) {
  const data = {
    '@context': 'https://schema.org',
    '@type': 'BreadcrumbList',
    itemListElement: items.map((c, i) => ({
      '@type': 'ListItem',
      position: i + 1,
      name: c.label,
      ...(c.to ? { item: `${siteConfig.url}${c.to}` } : {}),
    })),
  }
  return (
    <nav aria-label="Você está aqui" className={cn('text-[13px] font-medium text-brand-graphite', className)}>
      <JsonLd data={data} />
      <ol className="flex flex-wrap items-center gap-1.5">
        {items.map((c, i) => {
          const last = i === items.length - 1
          return (
            <li key={`${c.label}-${i}`} className="flex items-center gap-1.5">
              {c.to && !last ? (
                <Link to={c.to} className="rounded transition-colors hover:text-brand-purple">
                  {c.label}
                </Link>
              ) : (
                <span aria-current={last ? 'page' : undefined} className={cn(last && 'text-brand-purple')}>
                  {c.label}
                </span>
              )}
              {!last && <ChevronRight className="h-3.5 w-3.5 text-brand-gray" aria-hidden />}
            </li>
          )
        })}
      </ol>
    </nav>
  )
}
