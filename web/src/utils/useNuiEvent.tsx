import { useEffect } from "react";

type NuiHandler<T = any> = (data: T) => void;

export function useNuiEvent<T = any>(
  action: string,
  handler: NuiHandler<T>
): void {
  useEffect(() => {
    const listener = (event: MessageEvent) => {
      if (event.data?.action !== action) return;
      handler(event.data.data);
    };

    window.addEventListener("message", listener);

    return () => {
      window.removeEventListener("message", listener);
    };
  }, [action, handler]);
}