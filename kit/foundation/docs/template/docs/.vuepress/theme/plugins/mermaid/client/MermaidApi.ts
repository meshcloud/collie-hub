export interface MermaidApi {
  render: (
    id: string,
    txt: string,
    cb?: (svgCode: string, bindFunctions: (element: Element) => void) => void,
    container?: Element
  ) => Promise<string>;
}
