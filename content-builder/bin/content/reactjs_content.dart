import '../models/models.dart';
import '../constants/tech_ids.dart';

String _baseUrl =
    "https://raw.githubusercontent.com/samadfullstack/doks-content/version2/docs/reactjs/content";

TechModel reactjsContent = TechModel(
  techTitle: TechIds.reactJs.name,
  id: TechIds.reactJs.name,
  description: "Front-end javascript library",
  version: "18.2.0",
  downloadSize: "987 kb",
  related: [TechIds.tailwindCss.name, TechIds.reactJs.name],
  sectionsList: [
    SectionModel(
      sectionTitle: "Hooks",
      docList: [
        DocModel(
          docTitle: "hooks",
          url: "$_baseUrl/hooks.md",
          markdown: "",
          keywords: [],
        ),
        DocModel(
          docTitle: "use",
          url: "$_baseUrl/use.md",
          markdown: "",
          keywords: [],
        ),
        DocModel(
          docTitle: "useCallback",
          url: "$_baseUrl/useCallback.md",
          markdown: "",
          keywords: [],
        ),
        DocModel(
          docTitle: "useContext",
          url: "$_baseUrl/useContext.md",
          markdown: "",
          keywords: [],
        ),
        DocModel(
          docTitle: "useDebugValue",
          url: "$_baseUrl/useDebugValue.md",
          markdown: "",
          keywords: [],
        ),
        DocModel(
          docTitle: "useDeferredValue",
          url: "$_baseUrl/useDeferredValue.md",
          markdown: "",
          keywords: [],
        ),
        DocModel(
          docTitle: "useEffect",
          url: "$_baseUrl/useEffect.md",
          markdown: "",
          keywords: [],
        ),
        DocModel(
          docTitle: "useId",
          url: "$_baseUrl/useId.md",
          markdown: "",
          keywords: [],
        ),
        DocModel(
          docTitle: "useImperativeHandle",
          url: "$_baseUrl/useImperativeHandle.md",
          markdown: "",
          keywords: [],
        ),
        DocModel(
          docTitle: "useInsertionEffect",
          url: "$_baseUrl/useInsertionEffect.md",
          markdown: "",
          keywords: [],
        ),
        DocModel(
          docTitle: "useLayoutEffect",
          url: "$_baseUrl/useLayoutEffect.md",
          markdown: "",
          keywords: [],
        ),
        DocModel(
          docTitle: "useMemo",
          url: "$_baseUrl/useMemo.md",
          markdown: "",
          keywords: [],
        ),
        DocModel(
          docTitle: "useOptimistic",
          url: "$_baseUrl/useOptimistic.md",
          markdown: "",
          keywords: [],
        ),
        DocModel(
          docTitle: "useReducer",
          url: "$_baseUrl/useReducer.md",
          markdown: "",
          keywords: [],
        ),
        DocModel(
          docTitle: "useRef",
          url: "$_baseUrl/useRef.md",
          markdown: "",
          keywords: [],
        ),
        DocModel(
          docTitle: "useState",
          url: "$_baseUrl/useState.md",
          markdown: "",
          keywords: [],
        ),
        DocModel(
          docTitle: "useSyncExternalStore",
          url: "$_baseUrl/useSyncExternalStore.md",
          markdown: "",
          keywords: [],
        ),
        DocModel(
          docTitle: "useTransition",
          url: "$_baseUrl/useTransition.md",
          markdown: "",
          keywords: [],
        ),
      ],
    ),
    SectionModel(
      sectionTitle: "Components",
      docList: [
        DocModel(
          docTitle: "Component",
          url: "$_baseUrl/Component.md",
          markdown: "",
          keywords: [],
        ),
        DocModel(
          docTitle: "components",
          url: "$_baseUrl/components.md",
          markdown: "",
          keywords: [],
        ),
        DocModel(
          docTitle: "Fragment",
          url: "$_baseUrl/Fragment.md",
          markdown: "",
          keywords: [],
        ),
        DocModel(
          docTitle: "Profiler",
          url: "$_baseUrl/Profiler.md",
          markdown: "",
          keywords: [],
        ),
        DocModel(
          docTitle: "StrictMode",
          url: "$_baseUrl/StrictMode.md",
          markdown: "",
          keywords: [],
        ),
        DocModel(
          docTitle: "Suspense",
          url: "$_baseUrl/Suspense.md",
          markdown: "",
          keywords: [],
        ),
      ],
    ),
    SectionModel(
      sectionTitle: "Apis",
      docList: [
        DocModel(
          docTitle: "apis",
          url: "$_baseUrl/apis.md",
          markdown: "",
          keywords: [],
        ),
        DocModel(
          docTitle: "cache",
          url: "$_baseUrl/cache.md",
          markdown: "",
          keywords: [],
        ),
        DocModel(
          docTitle: "createContext",
          url: "$_baseUrl/createContext.md",
          markdown: "",
          keywords: [],
        ),
        DocModel(
          docTitle: "forwardRef",
          url: "$_baseUrl/forwardRef.md",
          markdown: "",
          keywords: [],
        ),
        DocModel(
          docTitle: "lazy",
          url: "$_baseUrl/lazy.md",
          markdown: "",
          keywords: [],
        ),
        DocModel(
          docTitle: "memo",
          url: "$_baseUrl/memo.md",
          markdown: "",
          keywords: [],
        ),
        DocModel(
          docTitle: "startTransition",
          url: "$_baseUrl/startTransition.md",
          markdown: "",
          keywords: [],
        ),
        DocModel(
          docTitle: "experimental_taintObjectReference",
          url: "$_baseUrl/experimental_taintObjectReference.md",
          markdown: "",
          keywords: [],
        ),
        DocModel(
          docTitle: "experimental_taintUniqueValue",
          url: "$_baseUrl/experimental_taintUniqueValue.md",
          markdown: "",
          keywords: [],
        ),
      ],
    ),
    SectionModel(
      sectionTitle: "Directives",
      docList: [
        DocModel(
          docTitle: "directives",
          url: "$_baseUrl/directives.md",
          markdown: "",
          keywords: [],
        ),
        DocModel(
          docTitle: "use-client",
          url: "$_baseUrl/use-client.md",
          markdown: "",
          keywords: [],
        ),
        DocModel(
          docTitle: "use-server",
          url:
              "https://github.com/samadfullstack/doks-content/raw/version2/docs/reactjs/content/use-server.md",
          markdown: "",
          keywords: [],
        ),
      ],
    ),
  ],
);
