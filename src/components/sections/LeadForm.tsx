import { useState } from 'react'
import { zodResolver } from '@hookform/resolvers/zod'
import { ArrowRight, CheckCircle2, Loader2 } from 'lucide-react'
import { useForm } from 'react-hook-form'
import { toast } from 'sonner'
import { Button } from '@/components/ui/button'
import { Form, FormControl, FormField, FormItem, FormLabel, FormMessage } from '@/components/ui/form'
import { Input } from '@/components/ui/input'
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select'
import { Textarea } from '@/components/ui/textarea'
import { cargoOptions, colaboradoresOptions, leadSchema, type LeadFormData } from '@/lib/leadSchema'
import { submitLead } from '@/lib/submitLead'
import { siteConfig } from '@/content/site'

export default function LeadForm() {
  const [enviado, setEnviado] = useState(false)

  const form = useForm<LeadFormData>({
    resolver: zodResolver(leadSchema),
    defaultValues: { nome: '', email: '', telefone: '', empresa: '', cargo: '', colaboradores: '', mensagem: '', novidades: false },
  })

  async function onSubmit(data: LeadFormData) {
    try {
      const result = await submitLead(data)
      if (result.demo) {
        toast.info('Modo demonstração: endpoint de leads ainda não configurado.', {
          description: 'Configure VITE_LEAD_WEBHOOK_URL para receber os contatos.',
        })
      }
      setEnviado(true)
    } catch {
      toast.error('Não conseguimos enviar agora. Tente novamente em instantes.', {
        description: `Se preferir, escreva para ${siteConfig.email}.`,
      })
    }
  }

  if (enviado) {
    return (
      <div className="flex h-full min-h-[420px] flex-col items-center justify-center py-12 text-center" role="status" aria-live="polite">
        <span className="flex h-16 w-16 items-center justify-center rounded-full bg-brand-purple/10 text-brand-purple">
          <CheckCircle2 className="h-8 w-8" strokeWidth={1.8} aria-hidden />
        </span>
        <h3 className="mt-5 text-2xl font-extrabold text-brand-ink">Recebemos o seu contato.</h3>
        <p className="mt-2 max-w-sm text-brand-graphite">
          Obrigado pelo interesse. Nosso time entra em contato em até 1 dia útil para agendar a demonstração com a
          realidade da sua empresa.
        </p>
      </div>
    )
  }

  const fieldClass = 'h-11 rounded-lg border-brand-mist bg-white focus-visible:ring-brand-purple'

  return (
    <Form {...form}>
      <form onSubmit={form.handleSubmit(onSubmit)} className="space-y-4" noValidate>
        <div className="grid gap-4 sm:grid-cols-2">
          <FormField
            control={form.control}
            name="nome"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Nome completo</FormLabel>
                <FormControl>
                  <Input className={fieldClass} placeholder="Seu nome" autoComplete="name" {...field} />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />
          <FormField
            control={form.control}
            name="telefone"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Telefone / WhatsApp</FormLabel>
                <FormControl>
                  <Input className={fieldClass} placeholder="(11) 99999-9999" autoComplete="tel" inputMode="tel" {...field} />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />
        </div>

        <FormField
          control={form.control}
          name="email"
          render={({ field }) => (
            <FormItem>
              <FormLabel>E-mail corporativo</FormLabel>
              <FormControl>
                <Input className={fieldClass} type="email" placeholder="voce@suaempresa.com.br" autoComplete="email" {...field} />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />

        <div className="grid gap-4 sm:grid-cols-2">
          <FormField
            control={form.control}
            name="empresa"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Empresa</FormLabel>
                <FormControl>
                  <Input className={fieldClass} placeholder="Nome da empresa" autoComplete="organization" {...field} />
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />
          <FormField
            control={form.control}
            name="cargo"
            render={({ field }) => (
              <FormItem>
                <FormLabel>Cargo</FormLabel>
                <Select onValueChange={field.onChange} value={field.value}>
                  <FormControl>
                    <SelectTrigger className={fieldClass}>
                      <SelectValue placeholder="Selecione" />
                    </SelectTrigger>
                  </FormControl>
                  <SelectContent>
                    {cargoOptions.map((c) => (
                      <SelectItem key={c} value={c}>
                        {c}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
                <FormMessage />
              </FormItem>
            )}
          />
        </div>

        <FormField
          control={form.control}
          name="colaboradores"
          render={({ field }) => (
            <FormItem>
              <FormLabel>Número de colaboradores</FormLabel>
              <Select onValueChange={field.onChange} value={field.value}>
                <FormControl>
                  <SelectTrigger className={fieldClass}>
                    <SelectValue placeholder="Selecione uma faixa" />
                  </SelectTrigger>
                </FormControl>
                <SelectContent>
                  {colaboradoresOptions.map((c) => (
                    <SelectItem key={c} value={c}>
                      {c}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
              <FormMessage />
            </FormItem>
          )}
        />

        <FormField
          control={form.control}
          name="mensagem"
          render={({ field }) => (
            <FormItem>
              <FormLabel>Mensagem (opcional)</FormLabel>
              <FormControl>
                <Textarea
                  className="rounded-lg border-brand-mist bg-white focus-visible:ring-brand-purple"
                  placeholder="Conte um pouco sobre a sua operação de RH: sistemas atuais, unidades, principais dores."
                  rows={3}
                  {...field}
                />
              </FormControl>
              <FormMessage />
            </FormItem>
          )}
        />

        <FormField
          control={form.control}
          name="novidades"
          render={({ field }) => (
            <FormItem className="flex items-start gap-3 space-y-0">
              <FormControl>
                <input
                  type="checkbox"
                  className="mt-[3px] h-4 w-4 shrink-0 cursor-pointer rounded border-brand-mist accent-brand-purple focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-brand-purple focus-visible:ring-offset-2"
                  name={field.name}
                  ref={field.ref}
                  onBlur={field.onBlur}
                  checked={!!field.value}
                  onChange={(e) => field.onChange(e.target.checked)}
                />
              </FormControl>
              <FormLabel className="cursor-pointer text-[13.5px] font-normal leading-relaxed text-brand-graphite">
                Quero receber novidades e conteúdos sobre RH e sobre a Natcorp.
              </FormLabel>
            </FormItem>
          )}
        />

        <Button type="submit" size="xl" className="w-full" disabled={form.formState.isSubmitting}>
          {form.formState.isSubmitting ? (
            <>
              <Loader2 className="animate-spin" aria-hidden />
              Enviando…
            </>
          ) : (
            <>
              Agendar demonstração
              <ArrowRight className="transition-transform duration-300 group-hover/btn:translate-x-0.5" />
            </>
          )}
        </Button>

        <p className="text-center text-xs leading-relaxed text-brand-graphite">
          Ao enviar, você concorda em ser contatado pela Natcorp. Seus dados são tratados conforme a LGPD (Lei nº
          13.709/2018).
        </p>
      </form>
    </Form>
  )
}
