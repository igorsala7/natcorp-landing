import { Suspense, lazy, useEffect } from 'react'
import { AnimatePresence } from 'motion/react'
import { BrowserRouter, HashRouter, Navigate, Route, Routes, useLocation, useMatch } from 'react-router'
import { Toaster } from '@/components/ui/sonner'
import { MotionProvider } from '@/components/motion/MotionProvider'
import { IntroProvider } from '@/components/motion/Intro'
import { SmoothScroll } from '@/components/motion/SmoothScroll'
import { ScrollProgress } from '@/components/motion/ScrollProgress'
import { ScrollManager } from '@/components/motion/ScrollManager'
import { Navbar } from '@/components/sections/Navbar'
import { Footer } from '@/components/sections/Footer'
import { CookieBar } from '@/components/sections/CookieBar'
import LandingPage from '@/pages/LandingPage'
import { paths } from '@/content/site'

const ModulesIndexPage = lazy(() => import('@/pages/ModulesIndexPage'))
const ModulePage = lazy(() => import('@/pages/ModulePage'))
const HiringJourneyPage = lazy(() => import('@/pages/HiringJourneyPage'))
const SegmentsIndexPage = lazy(() => import('@/pages/SegmentsIndexPage'))
const SegmentPage = lazy(() => import('@/pages/SegmentPage'))
const StructuresIndexPage = lazy(() => import('@/pages/StructuresIndexPage'))
const StructurePage = lazy(() => import('@/pages/StructurePage'))
const SystemPage = lazy(() => import('@/pages/SystemPage'))
const SecurityPage = lazy(() => import('@/pages/SecurityPage'))
const AboutPage = lazy(() => import('@/pages/AboutPage'))
const ContactPage = lazy(() => import('@/pages/ContactPage'))
const PortalsPage = lazy(() => import('@/pages/PortalsPage'))
const FaqPage = lazy(() => import('@/pages/FaqPage'))
const CommercialPage = lazy(() => import('@/pages/CommercialPage'))
const NotFoundPage = lazy(() => import('@/pages/NotFoundPage'))
const MotionPage = lazy(() => import('@/pages/MotionPage'))
const PresentationPage = lazy(() => import('@/pages/PresentationPage'))
const PortalHubPage = lazy(() => import('@/pages/PortalHubPage'))
const PortalAdminPage = lazy(() => import('@/pages/PortalAdminPage'))
const HostingDocsPage = lazy(() => import('@/pages/HostingDocsPage'))
const AnimaticPage = lazy(() => import('@/pages/AnimaticPage')) // TEMPORÁRIO: animatic do filme de 30s

/** HashRouter apenas para prévias hospedadas fora da raiz de um domínio (VITE_ROUTER=hash). */
const Router = import.meta.env.VITE_ROUTER === 'hash' ? HashRouter : BrowserRouter

function PageFallback() {
  return <div className="min-h-[70vh] bg-brand-off-white" aria-busy="true" aria-live="polite" />
}

function AppRoutes() {
  const location = useLocation()

  useEffect(() => {
    // Pré-carrega o template de módulo logo após a primeira renderização.
    const t = window.setTimeout(() => {
      void import('@/pages/ModulePage')
    }, 1200)
    return () => window.clearTimeout(t)
  }, [])

  return (
    <AnimatePresence mode="wait">
      <Routes location={location} key={location.pathname}>
        <Route path="/" element={<LandingPage />} />
        {[
          ['/sistema', <SystemPage />],
          ['/seguranca', <SecurityPage />],
          ['/sobre', <AboutPage />],
          ['/contato', <ContactPage />],
          ['/portais', <PortalsPage />],
          ['/perguntas-frequentes', <FaqPage />],
          ['/modelo-comercial', <CommercialPage />],
        ].map(([path, element]) => (
          <Route key={path as string} path={path as string} element={<Suspense fallback={<PageFallback />}>{element}</Suspense>} />
        ))}
        <Route
          path="/modulos"
          element={
            <Suspense fallback={<PageFallback />}>
              <ModulesIndexPage />
            </Suspense>
          }
        />
        <Route
          path="/modulos/:slug"
          element={
            <Suspense fallback={<PageFallback />}>
              <ModulePage />
            </Suspense>
          }
        />
        <Route
          path="/segmentos"
          element={
            <Suspense fallback={<PageFallback />}>
              <SegmentsIndexPage />
            </Suspense>
          }
        />
        <Route
          path="/segmentos/:slug"
          element={
            <Suspense fallback={<PageFallback />}>
              <SegmentPage />
            </Suspense>
          }
        />
        <Route
          path="/estruturas"
          element={
            <Suspense fallback={<PageFallback />}>
              <StructuresIndexPage />
            </Suspense>
          }
        />
        <Route
          path="/estruturas/:slug"
          element={
            <Suspense fallback={<PageFallback />}>
              <StructurePage />
            </Suspense>
          }
        />
        {/* Apresentação comercial em tela cheia, completa e reduzida (fora do menu e do sitemap). */}
        <Route
          path={paths.presentation}
          element={
            <Suspense fallback={<PageFallback />}>
              <PresentationPage version="completa" />
            </Suspense>
          }
        />
        <Route
          path={paths.presentationShort}
          element={
            <Suspense fallback={<PageFallback />}>
              <PresentationPage version="reduzida" />
            </Suspense>
          }
        />
        {/* TEMPORÁRIO: animatic do filme institucional, só para ser fotografado. */}
        <Route
          path="/animatic"
          element={
            <Suspense fallback={<PageFallback />}>
              <AnimaticPage />
            </Suspense>
          }
        />
        {/* Página interna de motion da marca (fora do menu e do sitemap). */}
        <Route
          path="/motion"
          element={
            <Suspense fallback={<PageFallback />}>
              <MotionPage />
            </Suspense>
          }
        />
        {/* Endereço antigo da página de grupos: agora é "Como é a sua estrutura?". */}
        <Route path="/grupos" element={<Navigate to="/estruturas" replace />} />
        <Route
          path="/portais_beta/dev/:cliente"
          element={
            <Suspense fallback={<PageFallback />}>
              <PortalHubPage env="dev" />
            </Suspense>
          }
        />
        <Route
          path="/portais_beta/:cliente"
          element={
            <Suspense fallback={<PageFallback />}>
              <PortalHubPage />
            </Suspense>
          }
        />
        {/* Documentação técnica de publicação, para a empresa de hospedagem
            (fora do menu, do sitemap e dos robôs; compartilhada por link). */}
        <Route
          path="/hospedagem"
          element={
            <Suspense fallback={<PageFallback />}>
              <HostingDocsPage />
            </Suspense>
          }
        />
        {/* Administração do cadastro dos portais (só para o administrador; fora do menu e do sitemap). */}
        <Route
          path={paths.portalAdmin}
          element={
            <Suspense fallback={<PageFallback />}>
              <PortalAdminPage />
            </Suspense>
          }
        />
        <Route
          path="/jornada-da-contratacao"
          element={
            <Suspense fallback={<PageFallback />}>
              <HiringJourneyPage />
            </Suspense>
          }
        />
        <Route
          path="*"
          element={
            <Suspense fallback={<PageFallback />}>
              <NotFoundPage />
            </Suspense>
          }
        />
      </Routes>
    </AnimatePresence>
  )
}

/**
 * A moldura do site (barra, rodapé, rolagem suave): fica de fora nas páginas em tela cheia, como a apresentação.
 * A porta de entrada dos portais (/portais_beta/<cliente>) e a administração (/admin/portais) têm cabeçalho e rodapé
 * próprios, sem o menu de marketing.
 */
function Shell() {
  const { pathname } = useLocation()
  // '/animatic' é TEMPORÁRIO: página fotografada quadro a quadro, sem moldura.
  const chromeless = pathname === paths.presentation || pathname === paths.presentationShort || pathname === '/animatic'
  const hubProd = useMatch('/portais_beta/:cliente')
  const hubDev = useMatch('/portais_beta/dev/:cliente')
  const admin = useMatch('/admin/*')
  const docs = useMatch('/hospedagem')
  // Páginas com cabeçalho próprio: o menu de marketing não ajuda quem está lá.
  const hub = hubProd !== null || hubDev !== null || admin !== null || docs !== null
  return (
    <>
      {/* A documentação fica sem rolagem suave: com o Lenis no caminho, as âncoras do índice
          e o Ctrl+F do navegador ficam imprevisíveis, e ali a pessoa está trabalhando. */}
      {!chromeless && !docs && <SmoothScroll />}
      {!chromeless && <ScrollProgress />}
      <ScrollManager />
      {!chromeless && !hub && <Navbar />}
      <main id="conteudo">
        <AppRoutes />
      </main>
      {!chromeless && !hub && <Footer />}
      {/* Fora do `chromeless` e do `hub`: consentimento vale em toda página,
          inclusive na apresentação e nos portais dos clientes. */}
      {pathname !== '/animatic' && <CookieBar />}
    </>
  )
}

function App() {
  return (
    <MotionProvider>
      <IntroProvider>
        <Router>
          <a
            href="#conteudo"
            className="sr-only focus:not-sr-only focus:fixed focus:left-4 focus:top-4 focus:z-[80] focus:rounded-lg focus:bg-white focus:px-4 focus:py-2 focus:text-sm focus:font-semibold focus:text-brand-purple focus:shadow-lift"
          >
            Pular para o conteúdo
          </a>
          <Shell />
          <Toaster position="bottom-right" />
        </Router>
      </IntroProvider>
    </MotionProvider>
  )
}

export default App
