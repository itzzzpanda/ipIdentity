export async function fetchNui<T = unknown>(
  eventName: string,
  data?: unknown,
  mockData?: T
): Promise<T> {
  const options = {
    method: "POST",
    headers: {
      "Content-Type": "application/json; charset=UTF-8",
    },
    body: JSON.stringify(data ?? {}),
  };

  const resourceName =
    typeof (window as any).GetParentResourceName === "function"
      ? (window as any).GetParentResourceName()
      : undefined;

  if (!resourceName && mockData) {
    return mockData;
  }

  const targetResource = resourceName ?? "nui-frame-app";

  try {
    const resp = await fetch(`https://${targetResource}/${eventName}`, options);
    const respFormatted = await resp.json();
    return respFormatted;
  } catch (error) {
    console.error(`fetchNui error for ${eventName}:`, error);
    throw error;
  }
}
