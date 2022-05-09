import { useState } from "react";
import Activity from "./activity_component";
import Search from "./search";

const Layout = () => {
  const [searchParams, setSearchParams] = useState({})

  return (
    <div>
      <Search
        setSearchParams={setSearchParams}
      />
      <Activity
        searchParams={searchParams}
        setSearchParams={setSearchParams}
      />
    </div>
  );
};

export default Layout;