declare module 'pdf-parse' { const parse: (input: Buffer) => Promise<{ text:string; info:Record<string, string>; numpages:number }>; export default parse; }
