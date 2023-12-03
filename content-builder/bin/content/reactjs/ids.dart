import '../../constants/tech_ids.dart';

enum Hooks {
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
  useTransition,
  ;

  String get prefix => "${TechIds.reactJs.name}:$name";
}

enum Components {
  component,
  components,
  fragment,
  profiler,
  strictMode,
  suspense,
  ;

  String get prefix => "${TechIds.reactJs.name}:$name";
}

enum Apis {
  apis,
  cache,
  createContext,
  forwardRef,
  lazy,
  memo,
  startTransition,
  experimentalTaintObjectReference,
  experimentalTaintUniqueValue,
  experimentalUseEffectEvent,
  ;

  String get prefix => "${TechIds.reactJs.name}:$name";
}

enum Directives {
  directives,
  useClient,
  useServer,
  ;

  String get prefix => "${TechIds.reactJs.name}:$name";
}
