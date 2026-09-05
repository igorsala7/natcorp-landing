import * as React from 'react'
import { Slot } from '@radix-ui/react-slot'
import { cva, type VariantProps } from 'class-variance-authority'

import { cn } from '@/lib/utils'

/* Botões do manual: raio 8 px, Manrope 600, um primário por tela. */
const buttonVariants = cva(
  'group/btn inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-lg text-sm font-semibold transition-[background-color,color,border-color,box-shadow,transform] duration-300 ease-brand focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:size-4 [&_svg]:shrink-0 active:translate-y-px',
  {
    variants: {
      variant: {
        default:
          'bg-brand-purple text-white shadow-[0_1px_2px_rgba(27,18,56,0.12)] hover:bg-brand-purple-hover hover:shadow-[0_12px_28px_-10px_rgba(81,28,118,0.55)]',
        secondary:
          'border border-brand-mist bg-white text-brand-purple hover:border-brand-purple/40 hover:bg-brand-off-white',
        outline: 'border border-brand-purple/30 bg-transparent text-brand-purple hover:bg-brand-purple/5',
        ghost: 'text-brand-ink hover:bg-brand-off-white',
        link: 'text-brand-purple underline-offset-4 hover:underline',
        /* sobre fundos roxos / azul profundo */
        inverse:
          'bg-white text-brand-purple shadow-[0_1px_2px_rgba(0,0,0,0.15)] hover:bg-brand-off-white hover:shadow-[0_16px_32px_-12px_rgba(0,0,0,0.45)]',
        'outline-inverse':
          'border border-white/35 bg-white/0 text-white backdrop-blur-sm hover:border-white/70 hover:bg-white/10',
        accent: 'bg-brand-pink text-white hover:bg-[#b84a79]',
        destructive: 'bg-destructive text-destructive-foreground hover:bg-destructive/90',
      },
      size: {
        default: 'h-10 px-4 py-2',
        sm: 'h-9 rounded-md px-3 text-[13px]',
        lg: 'h-12 px-6 text-[15px]',
        xl: 'h-14 px-8 text-base',
        icon: 'h-10 w-10',
      },
    },
    defaultVariants: {
      variant: 'default',
      size: 'default',
    },
  },
)

export interface ButtonProps
  extends React.ButtonHTMLAttributes<HTMLButtonElement>,
    VariantProps<typeof buttonVariants> {
  asChild?: boolean
}

const Button = React.forwardRef<HTMLButtonElement, ButtonProps>(
  ({ className, variant, size, asChild = false, ...props }, ref) => {
    const Comp = asChild ? Slot : 'button'
    return <Comp className={cn(buttonVariants({ variant, size, className }))} ref={ref} {...props} />
  },
)
Button.displayName = 'Button'

export { Button, buttonVariants }
