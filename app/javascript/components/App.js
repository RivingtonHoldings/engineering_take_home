import React, { useState } from "react";
import { Container, Pagination } from "@mui/material";
import useGetBuildings from "../hooks/useGetBuildings";
import Buildings from "./Buildings";
import Spinner from "./Spinner";

const App = () => {
  const [page, setPage] = useState(1);
  const { isLoading, buildings, meta, error } = useGetBuildings(page);

  const handleOnChange = (_, v) => {
    setPage(v);
  };

  if (isLoading) {
    return <Spinner />;
  } else {
    return (
      <Container>
        <h1 style={{display: "flex", justifyContent: "center"}}>Buildings</h1>
        <Buildings isLoading={isLoading} buildings={buildings} error={error} />
        <Pagination
          sx={{ display: "flex", justifyContent: "center" }}
          count={meta["total"] / 5}
          page={page}
          onChange={handleOnChange}
        />
      </Container>
    );
  }
};

export default App;