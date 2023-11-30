import '../models/models.dart';
import '../constants/tech_ids.dart';

String _baseUrl =
    "https://raw.githubusercontent.com/samadfullstack/doks-content/version2/docs/${TechIds.reactJs.name}/content";

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
        ..._Hooks.values.map((item) {
          return DocModel(
            docTitle: item.name,
            url: "$_baseUrl/${item.name}.md",
          );
        }),
      ],
    ),
    SectionModel(
      sectionTitle: "Components",
      docList: [
        ..._Components.values.map((item) {
          return DocModel(
            docTitle: item.name,
            url: "$_baseUrl/${item.name}.md",
          );
        }),
      ],
    ),
    SectionModel(
      sectionTitle: "Apis",
      docList: [
        ..._Apis.values.map((item) {
          return DocModel(
            docTitle: item.name,
            url: "$_baseUrl/${item.name}.md",
          );
        }),
      ],
    ),
    SectionModel(
      sectionTitle: "Directives",
      docList: [
        ..._Directives.values.map((item) {
          return DocModel(
            docTitle: item.name,
            url: "$_baseUrl/${item.name}.md",
          );
        }),
      ],
    ),
  ],
);

enum _Hooks {
  hooks,
  use,
  useCallback,
  useContext,
  useDebugValue,
  useDeferredValue,
  useEffect,
  useId,
  useImperativeHandle,
  useInsertionEffect,
  useLayoutEffect,
  useMemo,
  useOptimistic,
  useReducer,
  useRef,
  useState,
  useSyncExternalStore,
  useTransition
}

enum _Components {
  component,
  components,
  fragment,
  profiler,
  strictMode,
  suspense
}

enum _Apis {
  apis,
  cache,
  createContext,
  forwardRef,
  lazy,
  memo,
  startTransition,
  experimentalTaintObjectReference,
  experimentalTaintUniqueValue,
  experimentalUseEffectEvent
}

enum _Directives { directives, useClient, useServer }
